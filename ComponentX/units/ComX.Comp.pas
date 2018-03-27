/// <summary>
///   Модуль компонента.
/// </summary>
unit ComX.Comp;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls,

  ComX.Intf,
  ComX.DataModel,
  ComX.DataModel.Roles
  ;

type

  TBeforeReactionToDependenceEvent = procedure(Sender: TObject; var AValue: Variant) of object;
  TAfterReactionToDependenceEvent = procedure(Sender: TObject; AValue: Variant) of object;

  TComX = class(TWinControl, IComXView)
  private
    { Private declarations }
    InfoLabel: TLabel;
    IncButton: TButton;
    DecButton: TButton;

    RoleLabel: TLabel;

    FOnBeforeReactionToDependence: TBeforeReactionToDependenceEvent;
    FOnAfterReactionToDependence: TAfterReactionToDependenceEvent;

    FComXPublisher: TComX;

    procedure InitInternalComponents;
    procedure DoResize(Sender: TObject);
    procedure DoIncClick(Sender: TObject);
    procedure DoDecClick(Sender: TObject);

    procedure DoBeforeReactionToDependence(var AValue: Variant);
    procedure DoAfterReactionToDependence(AValue: Variant);


    procedure SetOnBeforeReactionToDependence(
      const Value: TBeforeReactionToDependenceEvent);

    procedure SetOnAfterReactionToDependence(
      const Value: TAfterReactionToDependenceEvent);


    procedure SetVisibleRoleInDesignTime(ARole: TComXRole);

    procedure _SetPublisher(AComXPublisher: TComX);

  protected
    { Protected declarations }
    FDataModel: IComXDataModel;

    procedure ShowCurrentValue(AValue: integer);

    procedure SetMin(AValue: Integer);
    procedure SetMax(AValue: integer);
    procedure SetDefault(AValue: integer);
    procedure SetRole(ARole: TComXRole);
    procedure SetPublisher(AComXPublisher: TComX);

    function GetMin: integer;
    function GetMax: integer;
    function GetDefault: integer;
    function GetRole: TComXRole;
    function GetPublisher: TComX;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    /// <summary>
    ///   Минимально допустимое значение.
    /// </summary>
    property ValueMin: integer read GetMin write SetMin;
    /// <summary>
    ///   Максимально допустимое значение.
    /// </summary>
    property ValueMax: integer read GetMax write SetMax;
    /// <summary>
    ///   Значение по умолчанию.
    /// </summary>
    property ValueDefault: integer read GetDefault write SetDefault;
    /// <summary>
    ///   Роль.
    /// </summary>
    property Role: TComXRole read GetRole write SetRole;
    /// <summary>
    ///   Издатель.
    /// </summary>
    property Publisher: TComX read GetPublisher write SetPublisher;

    property OnBeforeReactionToDependence: TBeforeReactionToDependenceEvent read FOnBeforeReactionToDependence write SetOnBeforeReactionToDependence;
    property OnAfterReactionToDependence: TAfterReactionToDependenceEvent read FOnAfterReactionToDependence write SetOnAfterReactionToDependence;
  end;

procedure Register;

implementation

uses
  Vcl.Graphics;

procedure Register;
begin
  RegisterComponents('MostraGroup', [TComX]);
end;

{ ComX }

constructor TComX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDataModel := TComXDataModel.Create(Self);

  Self.InitInternalComponents;

  Self.OnResize := DoResize;
  Self.Width    := 150;
  Self.Height   := 30;
end;

destructor TComX.Destroy;
begin
  if (csDesigning in Self.ComponentState)
  then
    RoleLabel.Free;

  DecButton.Free;
  IncButton.Free;
  InfoLabel.Free;

  inherited Destroy;
end;

procedure TComX.DoDecClick(Sender: TObject);
begin
  FDataModel.DecValue;
end;

procedure TComX.DoIncClick(Sender: TObject);
begin
  FDataModel.IncValue;
end;

procedure TComX.DoAfterReactionToDependence(AValue: Variant);
begin
  if Assigned(Self.FOnAfterReactionToDependence)
  then
    Self.FOnAfterReactionToDependence(Self, AValue);
end;

procedure TComX.DoBeforeReactionToDependence(var AValue: Variant);
begin
  if Assigned(Self.FOnBeforeReactionToDependence)
  then
    Self.FOnBeforeReactionToDependence(Self, AValue);

end;

procedure TComX.DoResize(Sender: TObject);
var
  FNewHeight: integer;
begin
  FNewHeight := Self.Height;

  IncButton.Width := FNewHeight;
  DecButton.Width := FNewHeight;
end;

function TComX.GetDefault: integer;
begin
  Result := FDataModel.GetDefault;
end;

function TComX.GetMax: integer;
begin
  Result := FDataModel.GetMax;
end;

function TComX.GetMin: integer;
begin
  Result := FDataModel.GetMin;
end;

function TComX.GetPublisher: TComX;
begin
  Result := Self.FComXPublisher;
end;

function TComX.GetRole: TComXRole;
begin
  Result := FDataModel.GetRole;
end;

procedure TComX.InitInternalComponents;
begin

  InfoLabel := TLabel.Create(Self);
  IncButton := TButton.Create(Self);
  DecButton := TButton.Create(Self);

  with IncButton do
    begin
      Parent := Self;
      Align := TAlign.alRight;
      Caption := '+';
      OnClick := Self.DoIncClick;
    end;

  with DecButton do
    begin
      Parent := Self;
      Align := TAlign.alRight;
      Caption := '-';
      OnClick := Self.DoDecClick;
    end;

  with InfoLabel do
    begin
      Parent := Self;
      Align := TAlign.alClient;
      Layout :=TTextLayout.tlCenter;
      Caption := '<Empty>';
    end;


  if (csDesigning in Self.ComponentState)
  then
    begin
      RoleLabel := TLabel.Create(Self);
      with RoleLabel do
        begin
          Parent := Self;
          Align := TAlign.alLeft;
          Font.Color := clRed;
          AutoSize := true;
        end;
    end;


end;

procedure TComX.SetDefault(AValue: integer);
begin
  FDataModel.SetDefault(AValue);
end;

procedure TComX.SetMax(AValue: integer);
begin
  FDataModel.SetMax(AValue);
end;

procedure TComX.SetMin(AValue: Integer);
begin
  FDataModel.SetMin(AValue);
end;

procedure TComX.SetOnAfterReactionToDependence(
  const Value: TAfterReactionToDependenceEvent);
begin
  FOnAfterReactionToDependence := Value;
end;

procedure TComX.SetOnBeforeReactionToDependence(
  const Value: TBeforeReactionToDependenceEvent);
begin
  FOnBeforeReactionToDependence := Value;
end;

procedure TComX.SetPublisher(AComXPublisher: TComX);
begin
  case Self.Role of
    Master:         Self._SetPublisher(nil);

    Slave,
    MasterAndSlave: Self._SetPublisher(AComXPublisher);
  end;
end;

procedure TComX.SetRole(ARole: TComXRole);
begin
  FDataModel.SetRole(ARole);

  if (csDesigning in Self.ComponentState)
  then
    Self.SetVisibleRoleInDesignTime(ARole);
end;

procedure TComX.SetVisibleRoleInDesignTime(ARole: TComXRole);
begin
  case ARole of
    Master:         RoleLabel.Caption := 'M';
    Slave:          RoleLabel.Caption := 'S';
    MasterAndSlave: RoleLabel.Caption := 'MS';
  end;
end;

procedure TComX.ShowCurrentValue(AValue: integer);
var
  FValue: Variant;
  FValueAsInt: integer;
begin
  FValue := AValue;
  self.DoBeforeReactionToDependence(FValue);

  FValueAsInt := FValue;
  InfoLabel.Caption := Format('Value: %d ', [FValueAsInt]);

  Self.DoAfterReactionToDependence(FValue);
end;

procedure TComX._SetPublisher(AComXPublisher: TComX);
begin
  Self.FComXPublisher := AComXPublisher;

  if Assigned(Self.FComXPublisher)
  then
    Self.FDataModel.SetPublisher(Self.FComXPublisher.FDataModel as IComXPublisher)
  else
    Self.FDataModel.SetPublisher(nil);
end;

end.
