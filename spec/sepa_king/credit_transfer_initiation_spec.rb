# encoding: utf-8
require 'spec_helper'

describe SEPA::CreditTransferInitiation do
  it 'should create valid XML file' do
    cti = SEPA::CreditTransferInitiation.new :name       => 'Schuldner GmbH',
                                             :bic        => 'BANKDEFFXXX',
                                             :iban       => 'DE87200500001234567890',
                                             :identifier => 'DE98ZZZ09999999999'

    cti.add_transaction :name                   => 'Telekomiker AG',
                        :iban                   => 'DE37112589611964645802',
                        :bic                    => 'PBNKDEFF370',
                        :amount                 => 102.50,
                        :remittance_information => 'Rechnung 123 vom 22.08.2013'

    cti.add_transaction :name                   => 'Amazonas GmbH',
                        :iban                   => 'DE27793589132923472195',
                        :bic                    => 'TUBDDEDDXXX',
                        :amount                 => 59.00,
                        :remittance_information => 'Rechnung 456 vom 21.08.2013'

    XML::Document.string(cti.to_xml).should validate_against('pain.001.002.03.xsd')
  end
end
