Rails.application.config.after_initialize do
  ActionText::ContentHelper.allowed_tags << "u"
end
