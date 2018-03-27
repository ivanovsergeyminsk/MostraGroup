unit ComX.DataModel;

interface

uses
  ComX.Intf,
  ComX.DataModel.Roles,
  ComX.DataModel.Publisher,

  System.Generics.Collections
  ;

type
  TComXDataModel = class(TInterfacedObject, IComXDataModel, IComXSubscriber, IComXPublisher)
  private
    FMinValue: integer;
    FMaxValue: integer;
    FValue: integer;
    FRole: TComXRole;
    FInnerPublisher: TComXPublisher;

    procedure InitValues;
  protected
    FComXView: IComXView;
    FPublisher: IComXPublisher;

    procedure DoChangeValue(AValue: integer);

    //IComXPublisher method.
    procedure AddSubscriber(ASubscriber: IComXSubscriber);
    procedure RemoveSubscriber(ASubscriber: IComXSubscriber);

    //IComXSubscriber method
    procedure NotifyChangedValue(AValue: integer);
  public
    constructor Create(AComXView: IComXView);
    destructor Destroy; override;

    procedure SetMin(AValue: integer);
    procedure SetDefault(AValue: integer);
    procedure SetMax(AValue: integer);
    procedure SetRole(ARole: TComXRole);
    procedure SetPublisher(APublisher: IComXPublisher);

    function GetMin: integer;
    function GetDefault: integer;
    function GetMax: integer;
    function GetRole: TComXRole;

    procedure IncValue;
    procedure DecValue;

  end;

implementation

{ TComXDataModel }

procedure TComXDataModel.AddSubscriber(ASubscriber: IComXSubscriber);
begin
  Self.FInnerPublisher.AddSubscriber(ASubscriber);
end;

constructor TComXDataModel.Create(AComXView: IComXView);
begin
  FInnerPublisher := TComXPublisher.Create;
  FPublisher := nil;
  Self.InitValues;
  FComXView := AComXView;
end;

procedure TComXDataModel.DecValue;
var
  FNewValue: integer;
begin
  FNewValue := Self.FValue - 1;
  Self.DoChangeValue(FNewValue);
end;

destructor TComXDataModel.Destroy;
begin
  FInnerPublisher.Free;

  inherited;
end;

procedure TComXDataModel.DoChangeValue(AValue: integer);
begin
  if (AValue < Self.FMinValue) or
     (AValue > Self.FMaxValue)
  then
    Exit;

  Self.FValue := AValue;

  FComXView.ShowCurrentValue(AValue);
  FInnerPublisher.NotifySubscribers(AValue);
end;

function TComXDataModel.GetDefault: integer;
begin
  Result := Self.FValue;
end;

function TComXDataModel.GetMax: integer;
begin
  Result := Self.FMaxValue;
end;

function TComXDataModel.GetMin: integer;
begin
  Result := Self.FMinValue;
end;

function TComXDataModel.GetRole: TComXRole;
begin
  Result := Self.FRole;
end;

procedure TComXDataModel.IncValue;
var
  FNewValue: integer;
begin
  FNewValue := Self.FValue + 1;
  Self.DoChangeValue(FNewValue);
end;

procedure TComXDataModel.InitValues;
begin
  Self.FMinValue := 0;
  Self.FMaxValue := 100;
  Self.FValue := 0;
  Self.FRole := TComXRole.MasterAndSlave;
end;

procedure TComXDataModel.NotifyChangedValue(AValue: integer);
begin
  DoChangeValue(AValue);
end;

procedure TComXDataModel.RemoveSubscriber(ASubscriber: IComXSubscriber);
begin
  Self.FInnerPublisher.RemoveSubscriber(ASubscriber);
end;

procedure TComXDataModel.SetDefault(AValue: integer);
begin
  Self.DoChangeValue(AValue);
end;

procedure TComXDataModel.SetMax(AValue: integer);
begin
  Self.FMaxValue := AValue;
end;

procedure TComXDataModel.SetMin(AValue: integer);
begin
  Self.FMinValue := AValue;
end;

procedure TComXDataModel.SetPublisher(APublisher: IComXPublisher);
begin
  if Assigned(Self.FPublisher) then
    Self.FPublisher.RemoveSubscriber(Self);

  Self.FPublisher := APublisher;

  if Assigned(Self.FPublisher) then
    Self.FPublisher.AddSubscriber(Self);
end;

procedure TComXDataModel.SetRole(ARole: TComXRole);
begin
  Self.FRole := ARole;
end;

end.
