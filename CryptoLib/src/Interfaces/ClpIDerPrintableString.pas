{ *********************************************************************************** }
{ *                              CryptoLib Library                                  * }
{ *                    Copyright (c) 2018 Ugochukwu Mmaduekwe                       * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ *                              Acknowledgements:                                  * }
{ *                                                                                 * }
{ *        Thanks to Sphere 10 Software (http://sphere10.com) for sponsoring        * }
{ *                        the development of this library                          * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

unit ClpIDerPrintableString;

{$I ..\Include\CryptoLib.inc}

interface

uses
  ClpIProxiedInterface,
  ClpCryptoLibTypes,
  ClpIDerStringBase;

type
  IDerPrintableString = interface(IDerStringBase)

    ['{119C220A-2672-48E3-A24A-11128B5F599B}']

    function GetStr: String;

    function Asn1Equals(asn1Object: IAsn1Object): Boolean;

    property Str: String read GetStr;

    function GetString(): String;

    function GetOctets(): TCryptoLibByteArray;

    procedure Encode(derOut: IDerOutputStream);

  end;

implementation

end.