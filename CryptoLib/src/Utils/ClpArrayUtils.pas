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

unit ClpArrayUtils;

{$I ..\Include\CryptoLib.inc}

interface

uses
  SysUtils,
  Math,
  ClpCryptoLibTypes;

resourcestring
  SInvalidLength = '%d " > " %d';

type
  TArrayUtils = class sealed(TObject)

  strict private
    class function GetLength(from, &to: Int32): Int32; static; inline;

  public

    class function AddStringArray(const A, B: TCryptoLibStringArray)
      : TCryptoLibStringArray;

    class function AreEqual(const A, B: TCryptoLibByteArray): Boolean;
      overload; static;

    class function AreEqual(const A, B: TCryptoLibInt32Array): Boolean;
      overload; static;

    class function GetArrayHashCode(const data: TCryptoLibByteArray): Int32;
      overload; static;

    class function GetArrayHashCode(const data: TCryptoLibInt32Array): Int32;
      overload; static;

    class function Prepend(const A: TCryptoLibByteArray; B: Byte)
      : TCryptoLibByteArray; static;

    class function CopyOfRange(data: TCryptoLibByteArray; from, &to: Int32)
      : TCryptoLibByteArray; static;

  end;

implementation

{ TArrayUtils }

class function TArrayUtils.GetLength(from, &to: Int32): Int32;
var
  newLength: Int32;
begin
  newLength := &to - from;
  if (newLength < 0) then
  begin
    raise EArgumentCryptoLibException.CreateResFmt(@SInvalidLength,
      [from, &to]);
  end;
  Result := newLength;
end;

class function TArrayUtils.AddStringArray(const A, B: TCryptoLibStringArray)
  : TCryptoLibStringArray;
var
  i, l: Int32;
begin
  l := System.Length(A);
  System.SetLength(Result, l + System.Length(B));
  for i := System.Low(A) to System.High(A) do
  begin
    Result[i] := A[i];
  end;

  for i := System.Low(B) to System.High(B) do
  begin
    Result[l + i] := B[i];
  end;
end;

class function TArrayUtils.AreEqual(const A, B: TCryptoLibByteArray): Boolean;
begin
  if System.Length(A) <> System.Length(B) then
  begin
    Result := false;
    Exit;
  end;

  Result := CompareMem(A, B, System.Length(A) * System.SizeOf(Byte));
end;

class function TArrayUtils.AreEqual(const A, B: TCryptoLibInt32Array): Boolean;
begin
  if System.Length(A) <> System.Length(B) then
  begin
    Result := false;
    Exit;
  end;

  Result := CompareMem(A, B, System.Length(A) * System.SizeOf(Int32));
end;

class function TArrayUtils.CopyOfRange(data: TCryptoLibByteArray;
  from, &to: Int32): TCryptoLibByteArray;
var
  newLength: Int32;
begin
  newLength := GetLength(from, &to);
  System.SetLength(Result, newLength);
  System.Move(data[from], Result[0], Min(newLength, System.Length(data) - from)
    * System.SizeOf(Byte));
end;

class function TArrayUtils.GetArrayHashCode(const data
  : TCryptoLibByteArray): Int32;
var
  i, hc: Int32;
begin
  if data = Nil then
  begin
    Result := 0;
    Exit;
  end;

  i := System.Length(data);
  hc := i + 1;

  System.Dec(i);
  while (i >= 0) do
  begin
    hc := hc * 257;
    hc := hc xor data[i];
    System.Dec(i);
  end;
  Result := hc;
end;

class function TArrayUtils.GetArrayHashCode(const data
  : TCryptoLibInt32Array): Int32;
var
  i, hc: Int32;
begin
  if data = Nil then
  begin
    Result := 0;
    Exit;
  end;

  i := System.Length(data);
  hc := i + 1;

  System.Dec(i);
  while (i >= 0) do
  begin
    hc := hc * 257;
    hc := hc xor data[i];
    System.Dec(i);
  end;
  Result := hc;
end;

class function TArrayUtils.Prepend(const A: TCryptoLibByteArray; B: Byte)
  : TCryptoLibByteArray;
var
  &length: Int32;
begin
  if (A = Nil) then
  begin
    Result := TCryptoLibByteArray.Create(B);
    Exit;
  end;

  Length := System.Length(A);
  System.SetLength(Result, Length + 1);
  System.Move(A[0], Result[1], Length * System.SizeOf(Byte));
  Result[0] := B;
end;

end.
