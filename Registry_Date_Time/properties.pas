{******************************************************************************}
{                                                                              }
{    Registry Date/Time Demo                                                   }
{    Copyright (c) 2002 by Object Vision                                       }
{    All rights reserved                                                       }
{                                                                              }
{    Written by: Rick McGee                                                    }
{                                                                              }
{    Object Vision Associates, Inc.                                            }
{    P.O. Box 23388                                                            }
{    Belleville, IL 62223                                                      }
{    www.object-vision.com                                                     }
{                                                                              }
{******************************************************************************}

unit Properties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, CommCtrl, ShellAPI, Registry, Regedit, jpeg;

type
  TPropertyDlg = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Cancel: TButton;
    lblNumberOfSubkeys: TLabel;
    lblLongestSubkey: TLabel;
    lblNumberOfValues: TLabel;
    lblLongestDataValueNameLength: TLabel;
    lblLongestDataValueLength: TLabel;
    lblGMTTime: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    lblFolderName: TLabel;
    Label7: TLabel;
    lblTime: TLabel;
    lblDate: TLabel;
    lblGMTDate: TLabel;
    lblLocalTime: TLabel;
    lblLocalDate: TLabel;
    Refresh: TTimer;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Image2: TImage;
    lblAbout: TLabel;
    lblCopyright: TLabel;
    lblComments: TLabel;
    lblUrl: TLabel;
    Bevel2: TBevel;
    Image3: TImage;
    lblObjectVisionAsso: TLabel;
    CanCollapse: TCheckBox;
    StayOnTop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure RefreshTimer(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lblUrlClick(Sender: TObject);
  private
    FRegistryPath: string;
    FFolderName: string;
    FGMTDate: string;
    FGMTTime: string;
    FLastKey: string;
    FLocalDate: string;
    FLocalTime: string;
    FLongestDataValueLength: string;
    FLongestDataValueNameLength: string;
    FLongestSubkey: string;
    FNumberOfSubkeys: string;
    FNumberOfValues: string;
    FRegedit: TRegedit;
    FRegKey: TRegistry;
    FRootKey: string;
    FTimeZone: string;
    FTimeZoneInfo: TTimeZoneInformation;
    function DateTimeToLocalDateTime(DateTime: TDateTime): TDateTime;
    procedure FileTimeToDateTime(ft: TFileTime; var dt: TDateTime);
    procedure Parseitup;
    procedure OpenRootKey;
    procedure SetFolderName(Value: string);
    procedure SetGMTTime(Value: string);
    procedure SetGMTDate(Value: string);
    procedure SetKeyProperties;
    procedure SetLocalDate(Value: string);
    procedure SetLocalTime(Value: string);
    procedure SetLongestDataValueLength(Value: string);
    procedure SetLongestDataValueNameLength(Value: string);
    procedure SetLongestSubkey(Value: string);
    procedure SetNumberOfSubkeys(Value: string);
    procedure SetNumberOfValues(Value: string);
  published
    property FolderName: string read FFolderName write SetFolderName;
    property GMTDate: string read FGMTDate write SetGMTDate;
    property GMTTime: string read FGMTTime write SetGMTTime;
    property LocalDate: string read FLocalDate write SetLocalDate;
    property LocalTime: string read FLocalTime write SetLocalTime;
    property LongestDataValueLength: string read FLongestDataValueLength write SetLongestDataValueLength;
    property LongestDataValueNameLength: string read FLongestDataValueNameLength write SetLongestDataValueNameLength;
    property LongestSubkey: string read FLongestSubkey write SetLongestSubkey;
    property NumberOfSubkeys: string read FNumberOfSubkeys write SetNumberOfSubkeys;
    property NumberOfValues: string read FNumberOfValues write SetNumberOfValues;
    property TimeZone: string read FTimeZone write FTimeZone;
  end;

var
  PropertyDlg: TPropertyDlg = nil;
  MutexHandle: THandle = 0;

implementation

{$R *.DFM}

procedure TPropertyDlg.CancelClick(Sender: TObject);
begin
  Close;
end;

function TPropertyDlg.DateTimeToLocalDateTime(DateTime: TDateTime): TDateTime;
  {- Get the time zone info from the local machine }
begin
  case GetTimeZoneInformation(FTimeZoneInfo) of
  TIME_ZONE_ID_STANDARD:
    Result := DateTime - (FTimeZoneInfo.Bias / 60 / 24);
  TIME_ZONE_ID_DAYLIGHT:
    Result := DateTime - ((FTimeZoneInfo.Bias + FTimeZoneInfo.DaylightBias) / 60 / 24);
  else
    Result := 0;
  end;
end;

procedure TPropertyDlg.FileTimeToDateTime(ft: TFileTime; var dt: TDateTime);
var
  SystemTime: TSystemTime;
  FileTime: TFileTime;
begin
  if FileTimeToLocalFileTime(ft, FileTime) then
  begin
    FileTimeToSystemTime(ft, SystemTime);
    dt := SystemTimeToDateTime(SystemTime);
  end;
end;

procedure TPropertyDlg.FormClose(Sender: TObject; var Action: TCloseAction);
  {- Close everything up and free the TRegistry instance }
begin
  FRegedit.Free;
  Action := caFree;
end;

procedure TPropertyDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  with FRegedit do
    if IsRunning then
      case MessageDlg('Close Microsoft''s Registry Editor?', mtConfirmation, mbYesNoCancel, 0) of
      mrYes   : Close;
      mrNo    : SetWindowCaption;
      mrCancel: CanClose := False;
      end;
end;

procedure TPropertyDlg.FormCreate(Sender: TObject);
begin
  {- Create a persistant registry instance }
  FRegKey := TRegistry.Create;
  {- Set up everything else }
  Caption := Application.Title;
  lblAbout.Caption := Application.Title;
  Application.HintPause := 100;
  FillChar(FTimeZoneInfo, SizeOf(FTimeZoneInfo), 0);
  {- Launch the registry editor }
  FRegedit := TRegedit.Create;
  {- Clumbsy, but works fine for this demo! }
  Top := FRegedit.GetListViewRect.Top + 10;
  Left := FRegedit.GetListViewRect.Left + 10;
  Refresh.Enabled := True;
end;

procedure TPropertyDlg.Parseitup;
  {- Splits up the "Value" obtained from regedit's statusbar }
var
  i: integer;
  Folder: string;
  function ReverseString(Value: string): string;
  var
    i: integer;
  begin
    for i := Length(Value) downto 1 do
      Result := Result + Value[i];
  end;
begin
  try
    FRootKey := '';
    FRegistryPath := FLastKey;
    {- Strip off My Computer or whatever else that appears before HKEY... }
    for i := 1 to Length(FRegistryPath) do
      if Pos('HKEY', FRegistryPath) = 1 then Break
      else Delete(FRegistryPath,1,1);
    {- Set the root key name }
    for i := 1 to Length(FRegistryPath) do
    begin
      if FRegistryPath[1] <> '\' then
        FRootKey := FRootKey + FRegistryPath[1]
      else Break;
      Delete(FRegistryPath,1,1);
    end;
    {- Set the folder name }
    Folder := '';
    for i := Length(FRegistryPath) downto 1 do
    begin
      if FRegistryPath[i] = '\' then Break
      else Folder := Folder + FRegistryPath[i];
    end;
    FolderName := ReverseString(Folder);
  except
    raise;
  end;
end;

procedure TPropertyDlg.OpenRootKey;
  {- Find and set the root key and opens the path value }
var
  i: HKEY;
begin
  with FRegKey do
    try
      for i := Low(HKEYS) to High(HKEYS) do
      if FRootKey = HKEYS[i] then
      begin
        RootKey := i;
        if FFolderName = '' then FolderName := FRootKey;
        OpenKeyReadOnly(FRegistryPath);
      end;
    except
      raise;
    end;
end;

procedure TPropertyDlg.RefreshTimer(Sender: TObject);
  {- Timer fires every 500ms matching regedit's listview refresh rate }
var
  Value: string;
begin
  with FRegedit do
    begin
      {- Halt execution if regedit is closed }
      if not IsRunning then Halt;
      {- Suspend the timer }
      Refresh.Enabled := Idle;
      {- Wait until regedit is completely open }
      while not Idle do;
      {- If regedit is minimized, hide the dialog otherwise show it }
      Visible := not IsMinimized;
      {- Grab the text from regedit's status bar }
      Value := GetStatusBarText;
    end;
  {- If the status bar value has changed, refresh everything }
  if FLastKey <> Value then
  begin
    {- Insure the "General" tab is activated during regedit user ops }
    PageControl1.ActivePageIndex := 0;
    FLastKey := Value;
    Parseitup;
    OpenRootKey;
    SetKeyProperties;
  end;
end;

procedure TPropertyDlg.SetFolderName(Value: string);
  {- Set the and display the name of the folder }
begin
  if FFolderName <> Value then
  begin
    FFolderName := Value;
    if FFolderName = '' then FFolderName := FRootKey;
    lblFolderName.Caption := FFolderName
  end;
end;

procedure TPropertyDlg.SetKeyProperties;
  {- This is where data is gathered transformed and displayed }
var
  RegDate: TDateTime;
  RegKeyInfo: TRegKeyInfo;
begin
  with FRegKey do
    try
      try
        GetKeyInfo(RegKeyInfo);
        with RegKeyInfo do
          begin
            NumberOfSubkeys := IntToStr(NumSubKeys);
            LongestSubkey := IntToStr(MaxSubKeyLen);
            NumberOfValues := IntToStr(NumValues);
            LongestDataValueNameLength := IntToStr(MaxValueLen);
            LongestDataValueLength := IntToStr(MaxDataLen);
            {- Convert the RegKeyInfo.FileTime member to system time }
            FileTimeToDateTime(FileTime, RegDate);
            GMTDate := DateToStr(RegDate);
            GMTTime := TimeToStr(RegDate);
            {- Convert system time to local time }
            RegDate := DateTimeToLocalDateTime(RegDate);
            LocalDate := DateToStr(RegDate);
            LocalTime := TimeToStr(RegDate);
            lblFolderName.Hint := FLastKey;
          end;
      except
        raise;
      end;
    finally
      CloseKey;
    end;
end;

procedure TPropertyDlg.SetLocalTime(Value: string);
  {- Sets and displays local time }
begin
  if FLocalTime <> Value then
  begin
    FLocalTime := Value;
    lblLocalTime.Caption := FLocalTime;
  end;
end;

procedure TPropertyDlg.SetLocalDate(Value: string);
  {- Sets and displays the local date }
begin
  if FLocalDate <> Value then
  begin
    FLocalDate := Value;
    lblLocalDate.Caption := FLocalDate;
  end;
end;

procedure TPropertyDlg.SetGMTTime(Value: string);
  {- Sets and displays the GMT time }
begin
  if FGMTTime <> Value then
  begin
    FGMTTime := Value;
    lblGMTTime.Caption := FGMTTime;
  end;
end;

procedure TPropertyDlg.SetGMTDate(Value: string);
  {- Sets and displays the GMT date }
begin
  if FGMTDate <> Value then
  begin
    FGMTDate := Value;
    lblGMTDate.Caption := FGMTDate;
  end;
end;

procedure TPropertyDlg.SetNumberOfSubkeys(Value: string);
  {- Sets and displays the number of subkeys }
begin
  if FNumberOfSubkeys <> Value then
  begin
    FNumberOfSubkeys := Value;
    lblNumberOfSubkeys.Caption := FNumberOfSubkeys;
  end;
end;

procedure TPropertyDlg.SetLongestSubkey(Value: string);
  {- Sets and displays the longest subkey }
begin
  if FLongestSubkey <> Value then
  begin
    FLongestSubkey := Value;
    lblLongestSubkey.Caption := FLongestSubkey;
  end;
end;

procedure TPropertyDlg.SetNumberOfValues(Value: string);
  {- Sets and displays the number of values }
begin
  if FNumberOfValues <> Value then
  begin
    FNumberOfValues := Value;
    lblNumberOfValues.Caption := FNumberOfValues;
  end;
end;

procedure TPropertyDlg.SetLongestDataValueNameLength(Value: string);
  {- Sets and displays the longest data value name length }
begin
  if FLongestDataValueNameLength <> Value then
  begin
    FLongestDataValueNameLength := Value;
    lblLongestDataValueNameLength.Caption := FLongestDataValueNameLength;
  end;
end;

procedure TPropertyDlg.SetLongestDataValueLength(Value: string);
  {- Sets and displays the longest data value length }
begin
  if FLongestDataValueLength <> Value then
  begin
    FLongestDataValueLength := Value;
    lblLongestDataValueLength.Caption := FLongestDataValueLength;
  end;
end;

procedure TPropertyDlg.lblUrlClick(Sender: TObject);
  {- Launches the default browser }
begin
  ShellExecute(HWnd_Desktop, nil, PChar(lblUrl.Caption), nil, nil, SW_SHOWNORMAL);
  FRegedit.Minimize;
end;

{- Startup code }
initialization
  {- Create a mutex for single instance }
  MutexHandle := CreateMutex(nil,True,PChar(ChangeFileExt(ExtractFileName(ParamStr(0)),'')));
  {- Test for and kill any second instance }
  if GetLastError = ERROR_ALREADY_EXISTS then Halt;
  {- Hide application from the TaskBar and Alt-Tab }
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
                GetWindowLong(Application.Handle, GWL_EXSTYLE)
                or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);

{- Exit code }
finalization
  {- Release mutex handle }
  if MutexHandle <> 0 then CloseHandle(MutexHandle);

end.
