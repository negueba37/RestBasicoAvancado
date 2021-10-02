inherited ServiceCliente: TServiceCliente
  inherited FDConnection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'select * from cliente'
      'where 1=1')
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
    object qryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(ID) FROM cliente'
      'WHERE 1 = 1')
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'select * from cliente'
      'where id = :id')
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
  end
end
