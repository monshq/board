def get_validation_error(model, attr, error)
  I18n.t("activerecord.attributes.#{model}.#{attr}") + ' ' +
    I18n.t("activerecord.errors.models.#{model}.attributes.#{attr}.#{error}")
end
