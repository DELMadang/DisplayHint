unit DM.MenuHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, Menus, AppEvnts,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TMenuItemHint = class(THintWindow)
  private
    ActiveMenuItem: TMenuItem;
    HideTimer: TTimer;
    ShowTimer: TTimer;

    procedure HideTime(Sender: TObject);
    procedure ShowTime(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoActivateHint(AMenuItem: TMenuItem);
  end;

implementation

{ TMenuItemHint }

constructor TMenuItemHint.Create(AOwner: TComponent);
begin
  inherited;

  ShowTimer := TTimer.Create(self);
  ShowTimer.Interval := Application.HintPause;

  HideTimer := TTimer.Create(self);
  HideTimer.Interval := Application.HintHidePause;
end;

destructor TMenuItemHint.Destroy;
begin
  hideTimer.OnTimer := nil;
  showTimer.OnTimer := nil;
  self.ReleaseHandle;

  inherited;
end;

procedure TMenuItemHint.DoActivateHint(AMenuItem: TMenuItem);
begin
  HideTime(self);

  if (AMenuItem = nil) or (AMenuItem.Hint = '') then
  begin
    ActiveMenuItem := nil;
    exit;
  end;

  ActiveMenuItem := AMenuItem;

  ShowTimer.OnTimer := ShowTime;
  HideTimer.OnTimer := HideTime;
end;

procedure TMenuItemHint.ShowTime(Sender: TObject);
var
  LRect: TRect;
  LWidth: integer;
  LHeight: integer;
begin
  if ActiveMenuItem <> nil then
  begin
    LWidth := Canvas.TextWidth(ActiveMenuItem.Hint);
    LHeight := Canvas.TextHeight(ActiveMenuItem.Hint);

    LRect.Left := Mouse.CursorPos.X + 16;
    LRect.Top := Mouse.CursorPos.Y + 16;
    LRect.Right := LRect.Left + LWidth + 6;
    LRect.Bottom := LRect.Top + LHeight + 4;

    ActivateHint(LRect, activeMenuItem.Hint);
  end;

  showTimer.OnTimer := nil;
end;

procedure TMenuItemHint.HideTime(Sender: TObject);
begin
  ReleaseHandle;

  HideTimer.OnTimer := nil;
end;

end.
