class PlayerSerializer < ActiveModel::Serializer
ActiveModelSerializers.config.adapter = :json
  attributes :id, :nombre, :nivel, :goles, :sueldo, :bono, :sueldo_completo, :equipo
  

  def nombre
    object.name
  end

  def nivel
    object.level
  end

  def goles
    object.goals
  end

  def sueldo
    object.salary
  end

  def bono
    object.bonus
  end

  def sueldo_completo
    object.total_salary
  end

  def equipo
    object.team
  end
end
