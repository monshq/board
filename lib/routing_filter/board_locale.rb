module RoutingFilter
  class BoardLocale < Locale
    
    def self.locales_pattern
      %r(^/([a-z]{2})(?=/|$)) #use first path with 2 lowcase letters as locale code
    end
    
  end
end