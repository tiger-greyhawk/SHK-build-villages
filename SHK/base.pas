unit base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, MMSystem, ShellAPI, CoolTrayIcon,
  Menus;

type
  TForm1 = class(TForm)
    Timers1: TTimer;
    PageControl1: TPageControl;
    Button2: TButton;
    Edit2: TEdit;
    ProgressBars1: TProgressBar;
    CalcCards: TDateTimePicker;
    CalcCardsButton: TButton;
    Memo1: TMemo;
    CoolTrayIcon1: TCoolTrayIcon;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure TimerVillage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timers1Timer(Sender: TObject);
    procedure CalcCardsButtonClick(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Exit1Click(Sender: TObject);
    procedure CoolTrayIcon1BalloonHintTimeout(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TVillage = class (TObject)
  public
    FList:TStringList;
    name:string;
    time:TDateTime;

    constructor Create;
    destructor Destroy; override;
    procedure FillForm(Sender: TObject);    
  end;

var
  Form1: TForm1;
  iTag:integer;
  mas: Array[1..25] of TVillage;
  iconData : TNotifyIconData;
  mymenu: Integer;

implementation

uses ShowMessage;

//uses base;

{$R *.dfm}

constructor TVillage.Create;
begin
  inherited;
  FList:=TStringList.Create;
end;

destructor TVillage.Destroy;
begin
  FList.Free;
  inherited;
end;


procedure TForm1.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
  Form1.Button2Click(Button2);
  Edit2.SelectAll;  
  end;
//     TabSheet1.Caption:=Edit1.Text
//  end;
//  Edit1.Text:=TimeToStr(DateTimePicker1.DateTime);
//  DateTimePicker1.DateTime:=StrToTime('0:00:10');
end;

procedure TForm1.Button1Click(Sender: TObject);
var  myHour, myMin, mySec, myMilli : Word;
     inout:Integer;
begin
  mymenu:=1;
  TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Position:=0;
  DecodeTime(TDateTimePicker(FindComponent('DateTimePicker'+IntToStr((TButton(Sender)).Tag))).Time, myHour, myMin, mySec, myMilli);
  TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Interval:= myMilli+MySec*1000+MyMin*1000*60+mYHour*1000*60*60;
  TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Enabled:=True;
  Timers1.Enabled:=True;
  TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Max:=TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Interval div 100;
//  ShowMessage(IntToStr(TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Max));
//  ShowMessage('1');


end;

procedure TForm1.TimerVillage(Sender: TObject);
begin
//  ShowMessage(IntToStr(TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Interval));
//  FlashWindow(Form1.Handle, True);
//  FlashWindow(Form1.Handle, false);
//  SetWindowPos(Handle, HWND_TOPMOST, Form1.Left, Form1.Top, Form1.Width, Form1.Height, SWP_SHOWWINDOW);
//  SetWindowLong(Handle, GWL_HWNDPARENT, GetDesktopWindow);

//  Shell_NotifyIcon(NIM_ADD, @iconData);
  TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Enabled:=False;

//  TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Max:=TTimer(FindComponent('Timer'+IntToStr((TButton(Sender)).Tag))).Interval;
//  Timer1.Max:=

//  ShowMessage('In village '+TTabSheet(Form1.FindComponent('TabSheet'+IntToStr((TButton(Sender)).Tag))).Caption+' finished constructions');
  CoolTrayIcon1.ShowBalloonHint(TTabSheet(Form1.FindComponent('TabSheet'+IntToStr((TButton(Sender)).Tag))).Caption, 'finished constructions', bitNone, 60);
  Form2.Memo1.Lines.Add('In village '+TTabSheet(Form1.FindComponent('TabSheet'+IntToStr((TButton(Sender)).Tag))).Caption+' finished constructions');
  if not Form2.Visible then Form2.ShowModal //;
  else
  begin
    (SetWindowPos(Form2.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE));
    (SetWindowPos(Form2.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE));
  end;
//  Shell_NotifyIcon(NIM_DELETE, @iconData);
//  SetWindowPos(Handle, HWND_NOTOPMOST, Form1.Left, Form1.Top, Form1.Width, Form1.Height, SWP_SHOWWINDOW);
//  Shell_NotifyIcon(NIM_MODIFY, );


end;

procedure TVillage.FillForm(Sender: TObject);
var DynTabSheet:TTabSheet;
    DynDateTimePicker:TDateTimePicker;
    DynButton:TButton;
    DynTimer:TTimer;
    DynProgressBar:TProgressBar;
begin
   DynTabSheet:=TTabSheet.Create(Form1);
   DynTabSheet.PageControl:=Form1.PageControl1;
   DynTabSheet.Name:='TabSheet'+IntToStr(iTag);
   DynTabSheet.Parent:=Form1.PageControl1;
   DynTabSheet.Caption:=Form1.Edit2.Text;

   DynDateTimePicker:=TDateTimePicker.Create(Form1);
   DynDateTimePicker.Parent:=TTabSheet(Form1.FindComponent('TabSheet'+IntToStr(iTag)));
   DynDateTimePicker.Name:='DateTimePicker'+IntToStr(iTag);
   DynDateTimePicker.Left:=20;
   DynDateTimePicker.Top:=20;
   DynDateTimePicker.Width:=145;
   DynDateTimePicker.Height:=25;
   DynDateTimePicker.Kind:=dtkTime;
   DynDateTimePicker.Time:=StrToTime('0:0:0');

   DynButton:=TButton.Create(Form1);
   DynButton.Parent:=TTabSheet(Form1.FindComponent('TabSheet'+IntToStr(iTag)));
   DynButton.Name:='DynButton'+IntToStr(iTag);
   DynButton.Caption:=('Go timer');
   DynButton.Tag:=iTag;
   DynButton.Left:=170;
   DynButton.Top:=20;
   DynButton.Width:=50;
   DynButton.Height:=25;
   DynButton.OnClick:=Form1.Button1Click;

   DynTimer:=TTimer.Create(Form1);
//   DynTimer.Parent:=TTabSheet(Form1.FindComponent('TabSheet'+IntToStr(iTag)));
   DynTimer.Name:='Timer'+IntToStr(iTag);
   DynTimer.OnTimer:=Form1.TimerVillage;
   DynTimer.Interval:=0;
   DynTimer.Enabled:=False;
   DynTimer.Tag:=iTag;

   DynProgressBar:=TProgressBar.Create(Form1);
   DynProgressBar.Name:='ProgressBar'+IntToStr(iTag);
   DynProgressBar.Tag:=iTag;
   DynProgressBar.Parent:=TTabSheet(Form1.FindComponent('TabSheet'+IntToStr(iTag)));
   DynProgressBar.Left:=20;
   DynProgressBar.Top:=50;
   DynProgressBar.Width:=500;
   DynProgressBar.Height:=25;
   DynProgressBar.Max:=1000000;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  iTag:=0;
  iconData.cbSize := sizeOf(iconData);
  iconData.Wnd := Handle;
  iconData.uID := 0;
  iconData.uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
  iconData.hIcon := Application.Icon.Handle;
  iconData.szTip := 'MailAlert';
  iconData.uCallbackMessage := WM_MOUSEMOVE;
//  mymenu:=0;
//  Shell_NotifyIcon(NIM_ADD, @iconData);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  inc(iTag);
  Mas[iTag]:=TVillage.Create;
  Mas[iTag].FillForm(Sender);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Edit2.SetFocus;
  Edit2.SelectAll;

end;

procedure TForm1.Timers1Timer(Sender: TObject);
var b:integer;
begin
  Inc(b);
  ProgressBars1.Max:=200;
  for b:=0 to ComponentCount-1 do
  if Components[b] is TProgressBar then
//  TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Position:=TProgressBar(FindComponent('ProgressBar'+IntToStr((TButton(Sender)).Tag))).Position+1;
  TProgressBar(Components[b]).Position:=TProgressBar(Components[b]).Position+10;
//  ProgressBars1.Position:=ProgressBars1.Position+10;
  if b = 100 then
  Timers1.Enabled:=False;
end;

procedure TForm1.CalcCardsButtonClick(Sender: TObject);
var  tTempor1, tTempor, myTime, MyTimeCard, myHour, myMin, mySec, myMilli : Word;

begin
  DecodeTime(CalcCards.Time, myHour, myMin, mySec, myMilli);
  MyTime:=myHour*3600+MyMin*60+MySec;
  MyTimeCard:=myTime div 2;
  myHour:=MyTimeCard div 3600;
  tTempor:=MyTimeCard mod 3600;
  myMin:=tTempor div 60;
  tTempor1:=tTempor mod 60;
  mySec:=tTempor1;
//  Edit1.Text:='';
//  Memo1.Text.add(IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));
  Memo1.Clear;
  Memo1.Lines.Add('X2 = '+IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));

  MyTimeCard:=myTime div 3;
  myHour:=MyTimeCard div 3600;
  tTempor:=MyTimeCard mod 3600;
  myMin:=tTempor div 60;
  tTempor1:=tTempor mod 60;
  mySec:=tTempor1;
//  Edit3.Text:=IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec);
  Memo1.Lines.Add('X3 = '+IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));

  MyTimeCard:=myTime div 4;
  myHour:=MyTimeCard div 3600;
  tTempor:=MyTimeCard mod 3600;
  myMin:=tTempor div 60;
  tTempor1:=tTempor mod 60;
  mySec:=tTempor1;
//  Edit3.Text:=IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec);
  Memo1.Lines.Add('X4 = '+IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));

  MyTimeCard:=myTime div 5;
  myHour:=MyTimeCard div 3600;
  tTempor:=MyTimeCard mod 3600;
  myMin:=tTempor div 60;
  tTempor1:=tTempor mod 60;
  mySec:=tTempor1;
//  Edit3.Text:=IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec);
  Memo1.Lines.Add('X5 = '+IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));

  MyTimeCard:=myTime div 6;
  myHour:=MyTimeCard div 3600;
  tTempor:=MyTimeCard mod 3600;
  myMin:=tTempor div 60;
  tTempor1:=tTempor mod 60;
  mySec:=tTempor1;
//  Edit3.Text:=IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec);
  Memo1.Lines.Add('X6 = '+IntToStr(myHour)+':'+IntToStr(myMin)+':'+IntToStr(mySec));


end;

procedure TForm1.CoolTrayIcon1DblClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CoolTrayIcon1.HideMainForm;
//  if (mymenu = 0) then
  CanClose := False;
//  else CanClose:=True;
end;

procedure TForm1.Exit1Click(Sender: TObject);
//var CanClose: Boolean;
//    mymenu: Integer;
begin
//  CanClose := True;
//  mymenu:= 1;
//  Form1.FormClose(Sender, CanClose);
  Application.Terminate;
  Exit;
end;


procedure TForm1.CoolTrayIcon1BalloonHintTimeout(Sender: TObject);
begin
  if mymenu=1 then CoolTrayIcon1.ShowBalloonHint(TTabSheet(Form1.FindComponent('TabSheet'+IntToStr((TButton(Sender)).Tag))).Caption, 'finished constructions', bitNone, 60);
end;

end.
