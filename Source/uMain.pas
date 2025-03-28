unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,

  DM.MenuHint;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    N1: TMenuItem;
    O1: TMenuItem;
    N2: TMenuItem;
    S1: TMenuItem;
    A1: TMenuItem;
  private
    FHintWindow: TMenuItemHint;

    procedure WMMenuSelect(var Msg: TWMMenuSelect); message WM_MENUSELECT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TfrmMain }

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  FHintWindow := TMenuItemHint.Create(Self);
end;

procedure TfrmMain.WMMenuSelect(var Msg: TWMMenuSelect);
var
  LMenuItem: TMenuItem;
  LSubMenu: HMENU;
begin
  inherited;

  LMenuItem := nil;

  if (Msg.MenuFlag <> $FFFF) or (Msg.IDItem <> 0) then
  begin
    if Msg.MenuFlag and MF_POPUP = MF_POPUP then
    begin
      LSubMenu := GetSubMenu(Msg.Menu, Msg.IDItem) ;
      LMenuItem := Menu.FindItem(LSubMenu, fkHandle);
    end
    else
    begin
      LMenuItem := Menu.FindItem(Msg.IDItem, fkCommand);
    end;
  end;

  FHintWindow.DoActivateHint(LMenuItem);
end;

end.
