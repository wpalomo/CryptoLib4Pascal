{ *********************************************************************************** }
{ *                              CryptoLib Library                                  * }
{ *                Copyright (c) 2018 - 20XX Ugochukwu Mmaduekwe                    * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ *                              Acknowledgements:                                  * }
{ *                                                                                 * }
{ *      Thanks to Sphere 10 Software (http://www.sphere10.com/) for sponsoring     * }
{ *                           development of this library                           * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

unit DerApplicationSpecificTests;

interface

uses
  Classes,
  SysUtils,
{$IFDEF FPC}
  fpcunit,
  testregistry,
{$ELSE}
  TestFramework,
{$ENDIF FPC}
  ClpHex,
  ClpArrayUtils,
  ClpCryptoLibTypes,
  ClpDerVisibleString,
  ClpIDerVisibleString,
  ClpDerTaggedObject,
  ClpIDerTaggedObject,
  ClpDerApplicationSpecific,
  ClpIDerApplicationSpecific,
  ClpDerInteger,
  ClpIDerInteger,
  ClpAsn1Object,
  ClpAsn1Tags;

type

  TCryptoLibTestCase = class abstract(TTestCase)

  end;

type

  TTestDerApplicationSpecific = class(TCryptoLibTestCase)
  private

  var
    FimpData, FcertData, FsampleData: TCryptoLibByteArray;

    procedure TestTaggedObject();

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDerApplicationSpecific;

  end;

implementation

{ TTestDerApplicationSpecific }

procedure TTestDerApplicationSpecific.SetUp;
begin
  inherited;
  FimpData := THex.Decode('430109');

  FcertData := THex.Decode
    ('7F218201897F4E8201495F290100420E44454356434145504153533030317F49' +
    '81FD060A04007F00070202020202811CD7C134AA264366862A18302575D1D787' +
    'B09F075797DA89F57EC8C0FF821C68A5E62CA9CE6C1C299803A6C1530B514E18' +
    '2AD8B0042A59CAD29F43831C2580F63CCFE44138870713B1A92369E33E2135D2' +
    '66DBB372386C400B8439040D9029AD2C7E5CF4340823B2A87DC68C9E4CE3174C' +
    '1E6EFDEE12C07D58AA56F772C0726F24C6B89E4ECDAC24354B9E99CAA3F6D376' +
    '1402CD851CD7C134AA264366862A18302575D0FB98D116BC4B6DDEBCA3A5A793' +
    '9F863904393EE8E06DB6C7F528F8B4260B49AA93309824D92CDB1807E5437EE2' +
    'E26E29B73A7111530FA86B350037CB9415E153704394463797139E148701015F' +
    '200E44454356434145504153533030317F4C0E060904007F0007030102015301' +
    'C15F25060007000400015F24060009000400015F37384CCF25C59F3612EEE188' +
    '75F6C5F2E2D21F0395683B532A26E4C189B71EFE659C3F26E0EB9AEAE9986310' +
    '7F9B0DADA16414FFA204516AEE2B');

  FsampleData := THex.Decode
    ('613280020780a106060456000104a203020101a305a103020101be80288006025101020109a080b2800a01000000000000000000');
end;

procedure TTestDerApplicationSpecific.TearDown;
begin
  inherited;

end;

procedure TTestDerApplicationSpecific.TestDerApplicationSpecific;
var
  encoded: TCryptoLibByteArray;
  appSpec, tagged, certObj: IDerApplicationSpecific;
  recVal, val: IDerInteger;
begin
  TestTaggedObject();

  appSpec := TAsn1Object.FromByteArray(FsampleData) as IDerApplicationSpecific;

  if (1 <> appSpec.ApplicationTag) then
  begin
    Fail('wrong tag detected');
  end;

  val := TDerInteger.Create(9);

  tagged := TDerApplicationSpecific.Create(false, 3, val);

  if ((not TArrayUtils.AreEqual(FimpData, tagged.GetEncoded()))) then
  begin
    Fail('implicit encoding failed');
  end;

  recVal := tagged.GetObject(TAsn1Tags.Integer) as IDerInteger;

  if ((not val.Equals(recVal))) then
  begin
    Fail('implicit read back failed');
  end;

  certObj := TAsn1Object.FromByteArray(FcertData) as IDerApplicationSpecific;

  if ((not certObj.IsConstructed()) or (certObj.ApplicationTag <> 33)) then
  begin
    Fail('parsing of certificate data failed');
  end;

  encoded := certObj.GetDerEncoded();

  if ((not TArrayUtils.AreEqual(FcertData, encoded))) then
  begin
    Fail('re-encoding of certificate data failed');
  end;
end;

procedure TTestDerApplicationSpecific.TestTaggedObject;
var
  isExplicit: Boolean;
  type1: IDerVisibleString;
  type2, type4: IDerApplicationSpecific;
  type3, type5: IDerTaggedObject;
begin
  // boolean explicit, int tagNo, ASN1Encodable obj
  // isExplicit := false;

  // Type1 :::= VisibleString
  type1 := TDerVisibleString.Create('Jones');
  if (not TArrayUtils.AreEqual(THex.Decode('1A054A6F6E6573'),
    type1.GetEncoded())) then
  begin
    Fail('ERROR: expected value doesn''t match!');
  end;

  // Type2 :::= [APPLICATION 3] IMPLICIT Type1
  isExplicit := false;
  type2 := TDerApplicationSpecific.Create(isExplicit, 3, type1);
  // type2.isConstructed()
  if (not TArrayUtils.AreEqual(THex.Decode('43054A6F6E6573'),
    type2.GetEncoded())) then
  begin
    Fail('ERROR: expected value doesn''t match!');
  end;

  // Type3 :::= [2] Type2
  isExplicit := true;
  type3 := TDerTaggedObject.Create(isExplicit, 2, type2);
  if (not TArrayUtils.AreEqual(THex.Decode('A20743054A6F6E6573'),
    type3.GetEncoded())) then
  begin
    Fail('ERROR: expected value doesn''t match!');
  end;

  // Type4 :::= [APPLICATION 7] IMPLICIT Type3
  isExplicit := false;
  type4 := TDerApplicationSpecific.Create(isExplicit, 7, type3);
  if (not TArrayUtils.AreEqual(THex.Decode('670743054A6F6E6573'),
    type4.GetEncoded())) then
  begin
    Fail('ERROR: expected value doesn''t match!');
  end;

  // Type5 :::= [2] IMPLICIT Type2
  isExplicit := false;
  type5 := TDerTaggedObject.Create(isExplicit, 2, type2);
  // type5.isConstructed()
  if (not TArrayUtils.AreEqual(THex.Decode('82054A6F6E6573'),
    type5.GetEncoded())) then
  begin
    Fail('ERROR: expected value doesn''t match!');
  end;
end;

initialization

// Register any test cases with the test runner

{$IFDEF FPC}
  RegisterTest(TTestDerApplicationSpecific);
{$ELSE}
  RegisterTest(TTestDerApplicationSpecific.Suite);
{$ENDIF FPC}

end.
