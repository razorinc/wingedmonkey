module MonkeyWings
  class Ovirt
    require 'rbovirt'

    def initialize(opts={})
      opts.merge! Providers.defaults[:rhev][:credentials]
      username    = opts[:username]
      password    = opts[:password]
      url         = opts[:url]
      datacenter  = opts[:datacenter]

      @client = OVIRT::Client.new(username, password, url, datacenter)
    end

    def create_vm(name, template_id, opts={})
      params = {}
      params[:name] = name
      params[:template] = template_id
      params[:cluster] = opts[:realm_id] if opts[:realm_id]
      params[:hwp_id] = opts[:hwp_id] if opts[:hwp_id]
      params[:memory] = (opts[:hwp_memory].to_i * 1024 * 1024) if opts[:hwp_memory]
      params[:cores] = opts[:hwp_cpu] if opts[:hwp_cpu]
      client.create_vm(params)
    end

    def client
      @client
    end
  end
end
