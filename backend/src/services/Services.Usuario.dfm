inherited ServiceUsuario: TServiceUsuario
  inherited FDConnection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT U.ID, U.NOME, U.LOGIN, U.STATUS, U.SEXO, U.TELEFONE'
      'FROM USUARIO U'
      'WHERE 1 = 1')
    Left = 232
    Top = 48
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryPesquisaLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 30
    end
    object qryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object qryPesquisaSEXO: TSmallintField
      FieldName = 'SEXO'
      Origin = 'SEXO'
    end
    object qryPesquisaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 21
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(U.ID)'
      'FROM USUARIO U'
      'WHERE 1 = 1')
  end
  inherited qryCadastro: TFDQuery
    BeforePost = qryCadastroBeforePost
    SQL.Strings = (
      
        'SELECT U.ID, U.NOME, U.LOGIN, U.SENHA, U.STATUS, U.SEXO, U.TELEF' +
        'ONE,U.FOTO'
      'FROM USUARIO U')
    Left = 296
    Top = 56
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryCadastroLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 30
    end
    object qryCadastroSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 30
    end
    object qryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object qryCadastroSEXO: TSmallintField
      FieldName = 'SEXO'
      Origin = 'SEXO'
    end
    object qryCadastroTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 21
    end
    object qryCadastroFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
      Visible = False
    end
  end
end
