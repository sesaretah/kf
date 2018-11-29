module ApplicationHelper

  def currencies
    @options = [
      [t(:rial), 1],
      [t(:toman) , 2],
      [t(:dollar) , 3],
      [t(:euro) , 2]
    ]
    return @options
  end

  def rcurrencies(i)
    if i != nil
      @options = [t(:rial),t(:toman), t(:dollar), t(:euro)]
      return @options[i.to_i-1]
    else
      return " "
    end
  end

end
