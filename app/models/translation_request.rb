class TranslationRequest
  def initialize(params)
    @params = params
  end

  def translate_keys
    translate.first
  end

  private

  def translate
    new_params = []
    @params.each do |k, v|
      if k == 'jugadores'
        new_params << ActionController::Parameters.new(
          I18n.t(k) => translate_params(v), 'action' => @params['action'],
          'controller' => @params['controller']
        )
        next
      end
      next
    end

    new_params
  end

  def translate_params(parameters)
    new_parameters = []
    parameters.each do |x|
      player = {}
      x.each do |k, v|
        player.merge!(I18n.t(k) => v)
      end
      new_parameters << ActionController::Parameters.new(player)
    end

    new_parameters
  end
end
