module AddressFunctions
  # :company, :department, :first_name, :last_name, :street, :postcode, :city

  def full_name
    respond_to?(:name)? name : "#{first_name} #{last_name}"
  end

  def company_with_department
    company + (department.present? ? " / #{department}" : "")
  end

  def postcode_with_city
    "#{postcode} #{city}"
  end

  def address(type=:default,separator=", ")
    return case type.to_sym
      when :postcode_city then postcode_with_city
      when :geo then [street, postcode_with_city, "Germany"].join(separator)
      when :short then [full_name, street].join(separator)
      when :full then [full_name, street, postcode_with_city].join(separator)
      else [street, postcode_with_city].join(separator)
    end
  end

end
