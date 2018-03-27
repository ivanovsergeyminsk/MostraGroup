unit MainFrom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ComX.Comp, Vcl.ExtCtrls;

const
  CS_NEWVALUE = 'New Value: %d';

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ComX0: TComX;
    ComX1: TComX;
    ComX2: TComX;
    ComX3: TComX;
    procedure ComX1AfterReactionToDependence(Sender: TObject; AValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ComX1AfterReactionToDependence(Sender: TObject;
  AValue: Variant);
var
  FValue: integer;
begin
  FValue := AValue;
  ShowMessage(Format(CS_NEWVALUE, [FValue]));
end;


end.
