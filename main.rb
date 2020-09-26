# frozen_string_literal: true

{
  actions: {
    analytics: {
      description: 'Retrieves <span class="provider">analytics</span>',
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        { analytics: get('analytics', input) }
      end,
      help: 'This action retrieves the analytics from Sms77.io.',
      input_fields: lambda do
        [
          {
            name: 'group_by',
            control_type: 'select',
            pick_list: 'group_by_picks'
          },
          { name: 'subaccounts' },
          { name: 'label' },
          { name: 'end' },
          { name: 'start' }
        ]
      end,
      output_fields: lambda do |object_definitions|
        [
          { name: 'analytics', type: 'array', of: 'object',
            properties: object_definitions['analytic'] }
        ]
      end,
      subtitle: 'Gets analytics for the given api key',
      title: 'Get analytics'
    },
    balance: {
      execute: lambda do |_connection, _input, _input_schema, _output_schema|
        { balance: get('balance') }
      end,
      description: 'Retrieves <span class="provider">balance</span>',
      help: 'This action retrieves the balance from Sms77.io.',
      output_fields: lambda do |_object_definitions|
        [{ name: 'balance', 'type': 'number' }]
      end,
      sample_output: lambda do |_connection, _input|
        get('balance')
      end,
      subtitle: 'Gets the account balance for the given api key',
      title: 'Get balance'
    },
    contacts_create: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['json'] = 1
        input['action'] = 'write'

        get('contacts', input)
      end,
      description: 'Create a <span class="provider">contact</span>',
      output_fields: lambda do |_object_definitions|
        [
          { name: 'return' },
          { name: 'id', 'type': 'integer' }
        ]
      end,
      title: 'Create contact'
    },
    contacts_del: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['json'] = 1
        input['action'] = 'del'

        get('contacts', input)
      end,
      description: 'Deletes a <span class="provider">contact</span>',
      input_fields: lambda do
        [
          { name: 'id', type: :integer, optional: false }
        ]
      end,
      output_fields: lambda do |_object_definitions|
        [{ name: 'return' }]
      end,
      title: 'Delete contact'
    },
    contacts_read: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['action'] = 'read'
        input['json'] = 1

        { contacts: get('contacts', input) }
      end,
      description: 'Retrieves <span class="provider">contacts</span>',
      output_fields: lambda do |_object_definitions|
        [
          { name: 'contacts', type: 'array', of: 'object', properties: [
            { name: 'ID' },
            { name: 'Name' },
            { name: 'Number' }
          ] }
        ]
      end,
      title: 'Read contacts'
    },
    contacts_edit: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['action'] = 'write'
        input['json'] = 1

        get('contacts', input)
      end,
      description: 'Edit a <span class="provider">contact</span>',
      input_fields: lambda do
        [
          { name: 'id', type: :integer, optional: false },
          { name: 'nick' },
          { name: 'empfaenger' },
          { name: 'email' }
        ]
      end,
      output_fields: lambda do |_object_definitions|
        [{ name: 'return' }]
      end,
      title: 'Edit contact'
    },
    lookup_cnam: {
      execute: lambda do |_connection, _input, _input_schema, _output_schema|
        _input['type'] = 'cnam'

        get('lookup', _input)
      end,
      description: 'Perform a <span class="provider">caller name delivery lookup</span>',
      input_fields: lambda do
        [{ control_type: 'phone', name: 'number', optional: false }]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'code' },
          { name: 'name' },
          { name: 'number' },
          { name: 'success' }
        ]
      end,
      title: 'Lookup caller name delivery'
    },
    lookup_format: {
      execute: lambda do |_connection, _input, _input_schema, _output_schema|
        _input['type'] = 'format'
        get('lookup', _input)
      end,
      description: 'Perform a <span class="provider">number format lookup</span>',
      input_fields: lambda do
        [{ control_type: 'phone', name: 'number', optional: false }]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'success', type: :boolean },
          { name: 'national' },
          { name: 'international' },
          { name: 'international_formatted' },
          { name: 'country_name' },
          { name: 'country_code' },
          { name: 'country_iso' },
          { name: 'carrier' },
          { name: 'network_type' }
        ]
      end,
      title: 'Lookup number format'
    },
    lookup_hlr: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['type'] = 'hlr'

        get('lookup', input)
      end,
      description: 'Perform a <span class="provider">home location register lookup</span>',
      input_fields: lambda do
        [{ control_type: 'phone', name: 'number', optional: false }]
      end,
      output_fields: lambda do |object_definitions|
        [
          { name: 'status', type: :boolean },
          { name: 'status_message' },
          { name: 'lookup_outcome', type: :boolean },
          { name: 'lookup_outcome_message' },
          { name: 'international_format_number' },
          { name: 'international_formatted' },
          { name: 'national_format_number' },
          { name: 'country_code' },
          { name: 'country_code_iso3' },
          { name: 'country_name' },
          { name: 'country_prefix' },
          { name: 'current_carrier', type: :object, properties: object_definitions['carrier'] },
          { name: 'original_carrier', type: :object, properties: object_definitions['carrier'] },
          { name: 'valid_number' },
          { name: 'reachable' },
          { name: 'ported' },
          { name: 'roaming' },
          { name: 'gsm_code' },
          { name: 'gsm_message' }
        ]
      end,
      title: 'Lookup home location register'
    },
    lookup_mnp: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['json'] = 1
        input['type'] = 'mnp'

        get('lookup', input)
      end,
      description: 'Perform a <span class="provider">mobile number portability lookup</span>',
      input_fields: lambda do
        [
          { control_type: 'phone', name: 'number', optional: false }
        ]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'success', type: :boolean },
          { name: 'code', type: :integer },
          { name: 'mnp', type: :object, properties: [
            { name: 'country' },
            { name: 'number' },
            { name: 'international_formatted' },
            { name: 'national_format' },
            { name: 'network' },
            { name: 'mccmnc' },
            { name: 'isPorted', type: :boolean }
          ] }
        ]
      end,
      title: 'Lookup mobile number portability'
    },
    pricing: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        get('pricing', input)
      end,
      description: 'Retrieves <span class="provider">pricing</span>',
      help: 'This action retrieves the pricing from Sms77.io.',
      input_fields: lambda do
        [
          { name: 'country' },
          {
            control_type: 'select',
            name: 'format',
            pick_list: 'pricing_formats'
          }
        ]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'countCountries', type: :integer },
          { name: 'countNetworks', type: :integer },
          { name: 'countries', type: :array, of: :object, properties: [
            { name: 'countryCode' },
            { name: 'countryName' },
            { name: 'countryPrefix' },
            { name: 'networks', type: 'array', of: :object, properties: [
              { name: 'mcc', type: 'number' },
              { name: 'mncs', type: 'array', properties: [{ name: 'mnc' }] },
              { name: 'networkName' },
              { name: 'price', type: :number },
              { name: 'features', type: :array, properties: [{ name: 'feature' }] },
              { name: 'comment' }
            ] }
          ] }
        ]
      end,
      title: 'Get pricing'
    },
    sms: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        input['json'] = 1

        post('sms')
          .request_format_multipart_form
          .payload(input)
      end,
      description: 'Send <span class="provider">SMS</span>',
      input_fields: lambda do
        [
          { name: 'debug', type: :select, pick_list: 'boolean_picks' },
          { name: 'delay', type: :timestamp },
          { name: 'details', type: :select, pick_list: 'boolean_picks' },
          { name: 'flash', type: :select, pick_list: 'boolean_picks' },
          { name: 'foreign_id' },
          { name: 'from' },
          { name: 'label' },
          { name: 'no_reload', type: :select, pick_list: 'boolean_picks' },
          { name: 'performance_tracking', type: :select, pick_list: 'boolean_picks' },
          { name: 'return_msg_id', type: :select, pick_list: 'boolean_picks' },
          { name: 'text', optional: false },
          { name: 'to', optional: false },
          { name: 'ttl', type: :integer },
          { name: 'udh' },
          { name: 'unicode', type: :select, pick_list: 'boolean_picks' },
          { name: 'utf8', type: :select, pick_list: 'boolean_picks' }
        ]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'balance', type: :number },
          { name: 'debug' },
          { name: 'messages', type: :array, properties: [
            { name: 'encoding' },
            { name: 'error' },
            { name: 'error_text' },
            { name: 'id' },
            { name: 'messages', type: :array },
            { name: 'parts', type: :integer },
            { name: 'price', type: :number },
            { name: 'recipient' },
            { name: 'sender' },
            { name: 'success', type: :boolean },
            { name: 'text' }
          ] },
          { name: 'sms_type' },
          { name: 'success' },
          { name: 'total_price', type: :number }
        ]
      end,
      title: 'Send SMS'
    },
    status: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        multiline_text = get('status', input)
        lines = multiline_text.split("\n")

        { status: lines[0], updated_at: lines[1] }
      end,
      description: 'Retrieves <span class="provider">status</span>',
      input_fields: lambda do
        [{ name: 'msg_id', optional: false }]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'status' },
          { name: 'updated_at', type: :date_time }
        ]
      end,
      title: 'Get status'
    },
    validate_for_voice: {
      execute: lambda do |_connection, input, _input_schema, _output_schema|
        get('validate_for_voice', input)
      end,
      description: 'Validate <span class="provider">caller ID</span> for the <span class="provider">Voice API</span>',
      input_fields: lambda do
        [{ name: 'number', optional: false }, { name: 'callback' }]
      end,
      output_fields: lambda do |_object_definitions|
        [
          { name: 'code' },
          { name: 'error' },
          { name: 'formatted_output' },
          { name: 'id', type: :integer },
          { name: 'sender' },
          { name: 'success', type: :boolean },
          { name: 'voice', type: :boolean }
        ]
      end,
      title: 'Validate For Voice'
    }
  },
  connection: {
    authorization: {
      type: 'api_key',
      credentials: lambda { |connection|
        params(p: connection['api_key'])
      }
    },
    base_uri: lambda do
      'https://gateway.sms77.io/api/'
    end,
    fields: [
      {
        hint: 'You can find your API key ' \
          '<a href="https://app.sms77.io/settings#httpapi"' \
          'target="_blank">here</a>',
        name: 'api_key',
        optional: false
      }
    ]
  },
  object_definitions: {
    carrier: {
      fields: lambda do
        [
          { name: 'country' },
          { name: 'name' },
          { name: 'network_code' },
          { name: 'network_type' }
        ]
      end
    },
    analytic: {
      fields: lambda do
        [
          { name: 'date', type: :date },
          { name: 'label' },
          { name: 'country' },
          { name: 'account' },

          { name: 'economy', type: :integer },
          { name: 'direct', type: :integer },
          { name: 'voice', type: :integer },
          { name: 'hlr', type: :integer },
          { name: 'mnp', type: :integer },
          { name: 'inbound', type: :integer },
          { name: 'usage_eur', type: :number }
        ]
      end
    }
  },
  pick_lists: {
    boolean_picks: lambda { |_connection|
      [
        ['Yes', 1],
        ['No', 0]
      ]
    },
    contacts_actions: lambda { |_connection|
      [
        %w[Read read],
        %w[Write write],
        %w[Del del]
      ]
    },
    lookup_types: lambda { |_connection|
      [
        %w[Format format],
        %w[CNAM cnam],
        %w[HLR hlr],
        %w[MNP mnp]
      ]
    },
    pricing_formats: lambda { |_connection|
      [
        %w[JSON json],
        %w[CSV csv]
      ]
    },
    group_by_picks: lambda { |_connection|
      [
        %w[Date date],
        %w[Label label],
        %w[Subaccount subaccount],
        %w[Country country]
      ]
    }
  },
  test: lambda do
    get('balance')
  end,
  title: 'Sms77'
}
