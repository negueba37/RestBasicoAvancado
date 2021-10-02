inherited ProvidersCadastro: TProvidersCadastro
  OldCreateOrder = True
  Width = 384
  object qryPesquisa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 208
    Top = 64
  end
  object qryRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 144
    Top = 40
    object qryRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
  object qryCadastro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 248
    Top = 112
  end
end
