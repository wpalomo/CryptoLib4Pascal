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

unit ClpIAsymmetricCipherKeyPairGenerator;

{$I ..\Include\CryptoLib.inc}

interface

uses
  ClpIKeyGenerationParameters,
  ClpIAsymmetricCipherKeyPair;

type
  IAsymmetricCipherKeyPairGenerator = interface(IInterface)
    ['{BC73E9BF-24B2-4833-A8DA-B690FCC81A2F}']

    // /**
    // * intialise the key pair generator.
    // *
    // * @param the parameters the key pair is to be initialised with.
    // */
    procedure Init(parameters: IKeyGenerationParameters);

    // /**
    // * return an AsymmetricCipherKeyPair containing the Generated keys.
    // *
    // * @return an AsymmetricCipherKeyPair containing the Generated keys.
    // */
    function GenerateKeyPair(): IAsymmetricCipherKeyPair;

  end;

implementation

end.