{******************************************************************************}
{                                                                              }
{    Simple interface to Microsoft's Registry Editor                           }
{    Copyright (c) 2002 by Object Vision                                       }
{    Object Vision Associates, Inc.                                            }
{    All rights reserved                                                       }
{                                                                              }
{    Written by: Rick McGee                                                    }
{                                                                              }
{******************************************************************************}

unit RegEdit;

interface

uses
  Windows, Messages, Classes, SysUtils, ShellAPI, CommCtrl;

const
  HKEYS: array[HKEY_CLASSES_ROOT..HKEY_DYN_DATA] of string = ('HKEY_CLASSES_ROOT',
                                                              'HKEY_CURRENT_USER',
                                                              'HKEY_LOCAL_MACHINE',
                                                              'HKEY_USERS',
                                                              'HKEY_PERFORMANCE_DATA',
                                                              'HKEY_CURRENT_CONFIG',
                                                              'HKEY_DYN_DATA');
type
  TRegedit = class(TObject)
  private
    FHijjackedBy: array[0..50] of char;
    FIdle: boolean;
    FListViewClass: pchar;
    FListViewHwnd: THandle;
    FListViewRect: TRect;
    FRegeditCaption: array[0..50] of char;
    FRegeditClass: pchar;
    FRegeditHwnd: THandle;
    FRegeditRect: TRect;
    FStatusBarClass: pchar;
    FStatusBarHwnd: THandle;
    FStatusBarRect: TRect;
    FTreeViewClass: pchar;
    FTreeViewHwnd: THandle;
    FTreeViewRect: TRect;
    procedure Collapse;
    procedure Execute;
    procedure GetBoundingBoxes;
    procedure GetHandles;
    procedure GetWindowCaption;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Close;
    procedure FocusWindow;
    function GetStatusBarText: string;
    function IsMinimized: boolean;
    function IsRunning: boolean;
    function Idle: boolean;
    function GetListViewRect: TRect;
    function GetRegeditRect: TRect;
    function GetStatusBarRect: TRect;
    function GetTreeViewRect: TRect;
    procedure Minimize;
    procedure Restore;
    procedure SetWindowCaption;
  end;

implementation

constructor TRegedit.Create;
begin
  FListViewClass := 'SysListView32';
  FRegeditClass := 'Regedit_Regedit';
  FStatusBarClass := 'msctls_statusbar32';
  FTreeViewClass := 'SysTreeView32';
  FListViewHwnd := 0;
  FRegeditHwnd := 0;
  FStatusBarHwnd := 0;
  FTreeViewHwnd := 0;
  FIdle := False;
  Execute;
  inherited Create;
end;

destructor TRegedit.Destroy;
begin
  inherited Destroy;
end;

procedure TRegedit.Close;
  {- Terminate regedit }
begin
  PostMessage(FRegeditHwnd, WM_CLOSE, 0, 0);
end;

procedure TRegedit.Collapse;
  {- Collapse all nodes in TreeView }
var
  pkey: HTREEITEM;
begin
  pkey := TreeView_GetLastVisible(FTreeViewHwnd);
  while TreeView_GetRoot(FTreeViewHwnd) <> pkey do
  begin
    pkey := TreeView_GetPrevVisible(FTreeViewHwnd, pkey);
    if TreeView_GetRoot(FTreeViewHwnd) <> pkey then
      TreeView_Expand(FTreeViewHwnd, pkey, TVE_COLLAPSE);
  end;
end;

procedure TRegedit.Execute;
  {- Launches regedit }
var
  Key: HTREEITEM;
  ShellInfo: TShellExecuteInfo;
begin

  if not IsRunning then
  begin
    FillChar(ShellInfo, SizeOf(TShellExecuteInfo), 0);
    with ShellInfo do
      begin
        cbSize := SizeOf(TShellExecuteInfo);
        fMask := SEE_MASK_NOCLOSEPROCESS;
        lpFile := 'regedit.exe';
        nShow := SW_SHOWNORMAL;
      end;
    ShellExecuteEx(@ShellInfo);
    WaitForInputIdle(ShellInfo.hProcess, INFINITE);
  end;

  {- Initialize all handles we'll need }
  GetHandles;

  {- Regedit minimized? }
  if IsMinimized then Restore;

  GetBoundingBoxes;

  {- Save regedit's window title }
  GetWindowCaption;

  {- Temporarily change Regedit's main window caption }
  FHijjackedBy := 'Registry Editor Hijacked by Object Vision';
  SendMessage(FRegeditHwnd, WM_SETTEXT, 0, LongInt(@FHijjackedBy));

  if FRegeditHwnd <> 0 then
  begin
    FocusWindow;
    {- Close up regedit's TreeView }
    Collapse;
    {- Now skip down to HKEY_CLASSES_ROOT }
    Key := TreeView_GetFirstVisible(FTreeViewHwnd);
    TreeView_SelectItem(FTreeViewHwnd, TreeView_GetNextVisible(FTreeViewHwnd, Key));
    SetFocus(FTreeViewHwnd);
  end;

  FIdle := True;

  {- Wait a short while...}
  Sleep(500);

end;

procedure TRegedit.GetBoundingBoxes;
  {- Retrieves the dimensions of bounding rectangles for all windows }
begin
  try
    GetWindowRect(FListViewHwnd, FListViewRect);
    GetWindowRect(FRegeditHwnd, FRegeditRect);
    GetWindowRect(FStatusBarHwnd, FStatusBarRect);
    GetWindowRect(FTreeViewHwnd, FTreeViewRect);
  except
    raise;
  end;
end;

procedure TRegedit.GetHandles;
  {- Set window handle variables }
begin
  try
    FRegeditHwnd := FindWindow(FRegeditClass, nil);
    FTreeViewHwnd := FindWindowEx(FRegeditHwnd, 0, FTreeViewClass, nil);
    FStatusBarHwnd := FindWindowEx(FRegeditHwnd, 0, FStatusBarClass, nil);
    FListViewHwnd := FindWindowEx(FRegeditHwnd, 0, FListViewClass, nil);
  except
    raise;
  end;
end;

function TRegedit.GetListViewRect: TRect;
  {- Returns the dimensions of the list view bounding rectangle }
begin
  Result := FListViewRect;
end;

function TRegedit.GetRegeditRect: TRect;
  {- Returns the dimensions of the regedit's bounding rectangle }
begin
  Result := FRegeditRect;
end;

function TRegedit.GetStatusBarRect: TRect;
  {- Returns the dimensions of the status bar's bounding rectangle }
begin
  Result := FStatusBarRect;
end;

function TRegedit.GetTreeViewRect: TRect;
  {- Returns the dimensions of the tree view bounding rectangle }
begin
  Result := FTreeViewRect;
end;

function TRegedit.GetStatusBarText: string;
  {- Obtain statusbar text }
var
  Size: integer;
  StrBuf: array [0..300] of char;
begin
  Size := SendMessage(FStatusBarHwnd, WM_GETTEXTLENGTH, 0, 0);
  SendMessage(FStatusBarHwnd, WM_GETTEXT, Size+1, LongInt(@StrBuf));
  Result := String(StrBuf);
end;

procedure TRegedit.GetWindowCaption;
  {- Store the value assigned to regedit's window title for later... }
var
  Size: integer;
begin
  Size := SendMessage(FRegeditHwnd, WM_GETTEXTLENGTH, 0, 0);
  SendMessage(FRegeditHwnd, WM_GETTEXT, Size+1, LongInt(@FRegeditCaption));
end;

procedure TRegedit.FocusWindow;
  {- Set focus to the tree view }
begin
  SetForegroundWindow(FTreeViewHwnd);
end;

function TRegedit.Idle: boolean;
  {- Return the Idle value }
begin
  Result := FIdle;
end;

function TRegedit.IsMinimized: boolean;
  {- Is regedit minimized? }
begin
  Result := IsIconic(FRegeditHwnd);
end;

function TRegedit.IsRunning: boolean;
  {- Is regedit is running? }
begin
  Result := not (FindWindow(FRegeditClass, nil) = 0);
end;

procedure TRegedit.Minimize;
  {- Minimize regedit }
begin
  ShowWindow(FRegeditHwnd, SW_MINIMIZE);
end;

procedure TRegedit.Restore;
  {- Restore regedit from a minimized state }
begin
  ShowWindow(FRegeditHwnd, SW_RESTORE);
end;

procedure TRegedit.SetWindowCaption;
  {- Restore Microsoft's intended window title for regedit }
begin
  SendMessage(FRegeditHwnd, WM_SETTEXT, 0, LongInt(@FRegeditCaption));
end;

end.
