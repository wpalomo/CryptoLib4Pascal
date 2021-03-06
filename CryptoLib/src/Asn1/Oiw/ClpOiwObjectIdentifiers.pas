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

unit ClpOiwObjectIdentifiers;

{$I ..\..\Include\CryptoLib.inc}

interface

uses
  ClpDerObjectIdentifier,
  ClpIDerObjectIdentifier;

type
  TOiwObjectIdentifiers = class abstract(TObject)

  strict private

    class var

      FIdSha1: IDerObjectIdentifier;

    class function GetIdSha1: IDerObjectIdentifier; static; inline;

    class constructor OiwObjectIdentifiers();

  public

    // id-SHA1 OBJECT IDENTIFIER ::=
    // {iso(1) identified-organization(3) oiw(14) secsig(3) algorithms(2) 26 }    //
    class property IdSha1: IDerObjectIdentifier read GetIdSha1;

    class procedure Boot(); static;

  end;

implementation

{ TOiwObjectIdentifiers }

class procedure TOiwObjectIdentifiers.Boot;
begin
  FIdSha1 := TDerObjectIdentifier.Create('1.3.14.3.2.26');
end;

class function TOiwObjectIdentifiers.GetIdSha1: IDerObjectIdentifier;
begin
  Result := FIdSha1;
end;

class constructor TOiwObjectIdentifiers.OiwObjectIdentifiers;
begin
  TOiwObjectIdentifiers.Boot;
end;

end.
