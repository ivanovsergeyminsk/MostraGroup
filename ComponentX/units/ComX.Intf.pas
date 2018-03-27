unit ComX.Intf;

interface

uses
  ComX.DataModel.Roles;

type

  IComXSubscriber = interface
  ['{7A06F2B6-861E-45CD-90D6-C2389C15356D}']
  procedure NotifyChangedValue(AValue: integer);
  end;

  IComXPublisher = interface
  ['{C6D68170-BD83-476F-A00E-52188FDC9CAC}']
  procedure AddSubscriber(ASubscriber: IComXSubscriber);
  procedure RemoveSubscriber(ASubscriber: IComXSubscriber);
  end;

  IComXView = interface
  ['{4EB6AB9E-0BAA-4960-A667-F279CE418183}']
  procedure ShowCurrentValue(AValue: integer);
  end;

  IComXDataModel = interface
  ['{8A275F17-B1E1-4CD0-97E2-532464FC5FE0}']
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

end.
