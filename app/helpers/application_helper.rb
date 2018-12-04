module ApplicationHelper

  def currencies
    @options = [
      [t(:toman), 1]
    ]
    return @options
  end
  # !!! IF changed also change application controller
  def rcurrencies(i)
    if i != nil
      @options = [t(:toman)]
      return @options[i.to_i-1]
    else
      return " "
    end
  end

end
