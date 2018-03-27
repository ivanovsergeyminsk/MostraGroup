unit ComX.DataModel.Publisher;

interface

uses
  ComX.Intf,
  System.Generics.Collections
  ;

type
  TComXPublisher = class(TInterfacedObject, IComXPublisher)
  private
    FSubscribers: TList<IComXSubscriber>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure NotifySubscribers(AValue: integer);
    procedure AddSubscriber(ASubscriber: IComXSubscriber);
    procedure RemoveSubscriber(ASubscriber: IComXSubscriber);
  end;


implementation

{ TComXPublisher }

procedure TComXPublisher.AddSubscriber(ASubscriber: IComXSubscriber);
begin
  FSubscribers.Add(ASubscriber)
end;

constructor TComXPublisher.Create;
begin
  FSubscribers := TList<IComXSubscriber>.Create;
end;

destructor TComXPublisher.Destroy;
begin
  FSubscribers.Free;
  inherited;
end;

procedure TComXPublisher.NotifySubscribers(AValue: integer);
var
  I: integer;
  FCount: integer;
begin
  FCount := Self.FSubscribers.Count - 1;
  for I := 0 to FCount
  do
    begin
      Self.FSubscribers[I].NotifyChangedValue(AValue);
    end;
end;

procedure TComXPublisher.RemoveSubscriber(ASubscriber: IComXSubscriber);
begin
  FSubscribers.Remove(ASubscriber);
end;

end.
