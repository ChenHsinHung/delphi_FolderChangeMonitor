unit Unit1;

{$WARN UNIT_PLATFORM OFF}

interface



uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,FileCtrl, StdCtrls, Buttons,FolderMon ;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    edtFolder: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    mmLogs: TMemo;
    ckbFilenameChange: TCheckBox;
    ckbDirNameChange: TCheckBox;
    ckbAttrChange: TCheckBox;
    ckbSizeChange: TCheckBox;
    ckbWriteTimeChange: TCheckBox;
    ckbAccessTimeChange: TCheckBox;
    ckbCreationTimeChange: TCheckBox;
    ckbSecurityAttrChanges: TCheckBox;
    ckbMonitorSubfolders: TCheckBox;
    btnActivate: TBitBtn;
    btnClearLog: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    bkpFolder: TEdit;
    SpeedButton2: TSpeedButton;
    Button1: TButton;

    procedure FormCreate(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }

    FFolderMon: TFolderMon;
    procedure HandleFolderChange(ASender: TFolderMon; AFolderItem: TFolderItemInfo);
    procedure HandleFolderMonActivated(ASender: TObject);
    procedure HandleFolderMonDeactivated(ASender: TObject);
    function FindRandomTextFile(var AFilename: string): Boolean;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}

function TForm1.FindRandomTextFile(var AFilename: string): Boolean;
var
  F: TSearchRec;
  i: Integer;
begin
  Result := False;
  i := 0;
  if FindFirst(FFolderMon.Folder + '\*.txt', faAnyFile, F) = 0 then
    repeat
      if (F.Name<>'.') and (F.Name<>'..') then
        Inc(i);
    until FindNext(F) <> 0;
  FindClose(F);

  if i=0 then Exit;

  i := Random(i) + 1;
  if FindFirst(FFolderMon.Folder + '\*.txt', faAnyFile, F) = 0 then
    repeat
      if (F.Name<>'.') and (F.Name<>'..') then
        Dec(i);
      if i=0 then
        AFilename := FFolderMon.Folder + '\' + F.Name;
    until (i=0) or (FindNext(F) <> 0);
  FindClose(F);
  Result := True;

end;

procedure TForm1.HandleFolderChange(ASender: TFolderMon;
  AFolderItem: TFolderItemInfo);

begin

  mmLogs.Lines.Add( FormatDateTime('yyyymmddhhnnss',now) +' \ Item: ' + ASender.Folder + '\' + AFolderItem.Name + '; ' +
    FOLDER_ACTION_NAMES[AFolderItem.Action]);

 //---

 if (AFolderItem.Action = faModified) or
     (AFolderItem.Action = faNew) 
    then
    // mmLogs.Lines.Add( AFolderItem.Name +' Copy to  '+self.bkpFolder.Text );
     CopyFile(PChar(ASender.Folder + '\' + AFolderItem.Name), PChar(bkpFolder.Text + '\' + FormatDateTime('yyyymmddhhnnss',now)+'.txt'  ), False)



end;

procedure TForm1.HandleFolderMonActivated(ASender: TObject);
begin
  btnActivate.Caption := 'Deactivate';
end;

procedure TForm1.HandleFolderMonDeactivated(ASender: TObject);
begin
  btnActivate.Caption := 'Activate';
end;

//-------------




procedure TForm1.FormCreate(Sender: TObject);
begin

  Randomize;
  btnClearLog.Click;

  FFolderMon := TFolderMon.Create;  // 建  object Thread
  
                             //掛上 Event
  FFolderMon.OnActivated    := HandleFolderMonActivated;
  FFolderMon.OnDeactivated  := HandleFolderMonDeactivated;
  FFolderMon.OnFolderChange := HandleFolderChange;

  edtFolder.Text := ExtractFileDir(ParamStr(0));
  self.bkpFolder.Text := ExtractFileDir(ParamStr(0));

end;

procedure TForm1.btnActivateClick(Sender: TObject);
var
  vMonitoredChanges: TChangeTypes;
begin

  if FFolderMon.IsActive then
    FFolderMon.Deactivate
  else begin
    FFolderMon.Folder := edtFolder.Text;
    vMonitoredChanges := [];

    if ckbFilenameChange.Checked then
      Include(vMonitoredChanges, ctFileName);

    if ckbDirNameChange.Checked then
      Include(vMonitoredChanges, ctDirName);

    if ckbAttrChange.Checked then
      Include(vMonitoredChanges, ctAttr);

    if ckbSizeChange.Checked then
      Include(vMonitoredChanges, ctSize);

    if ckbWriteTimeChange.Checked then
      Include(vMonitoredChanges, ctLastWriteTime);

    if ckbAccessTimeChange.Checked then
      Include(vMonitoredChanges, ctLastAccessTime);

    if ckbCreationTimeChange.Checked then
      Include(vMonitoredChanges, ctCreationTime);

    if ckbSecurityAttrChanges.Checked then
      Include(vMonitoredChanges, ctSecurityAttr);

    FFolderMon.MonitoredChanges := vMonitoredChanges;

    FFolderMon.MonitorSubFolders := ckbMonitorSubfolders.Checked;  //子目錄同步

    FFolderMon.Activate;    //啟動監控
  end;


end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  vDir: string;
begin
  vDir := edtFolder.Text;
  if not SelectDirectory(vDir, [], 0) then Exit;
  edtFolder.Text := vDir;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  vContent: TStrings;
  i, t, vLineCount: Integer;
begin

  vLineCount := Random(30) + 1;
  vContent := TStringList.Create;
  try
    for i := 1 to vLineCount do
    begin
      t := Random(MaxInt);
      vContent.Add(IntToStr(t));
    end;
    t := Random(439433);
    vContent.SaveToFile(FFolderMon.Folder + '\' + IntToStr(t) + '.txt');
  finally
    vContent.Free;
  end;


end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  vTxtFile: string;
begin
  if FindRandomTextFile(vTxtFile) then
    DeleteFile(vTxtFile);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FFolderMon.Free;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  i: Integer;
  vContent: TStrings;
  vTxtFile: string;
begin
  if not FindRandomTextFile(vTxtFile) then Exit;
  vContent := TStringList.Create;
  try
    for i := 0 to Random(443) do
      vContent.Add(IntToStr(Random(MaxInt)));

    vContent.SaveToFile(vTxtFile);
  finally
    vContent.Free;
  end;


end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  i: Integer;
  vTxtFile: string;
begin
  if not FindRandomTextFile(vTxtFile) then
    Exit;

  i := Random(478334) + 1;
  RenameFile(vTxtFile, ExtractFilePath(vTxtFile) + IntToStr(i) + '.txt');

end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  vDir: string;
begin
  vDir := bkpFolder.Text;
  if not SelectDirectory(vDir, [], 0) then Exit;
  bkpFolder.Text := vDir;

end;

procedure TForm1.btnClearLogClick(Sender: TObject);
begin
self.mmLogs.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

self.mmLogs.Lines.SaveToFile( bkpFolder.Text + '\' + FormatDateTime('yyyymmddhhnnss',now)+'.log' );

Self.btnClearLog.Click();


end;

end.

