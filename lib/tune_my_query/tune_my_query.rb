module TuneMyQuery
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      # Why do we need to do this? Because in class_eval self and base would be same but alias_method is private in ActiveRecord::Base and therefore, it is not visible to the outside world. So, we do class << self to open up the singleton class of ActiveRecord base and extend the functionality that ways.
      class << self
        alias_method :super_merge_conditions, :merge_conditions
        alias_method :merge_conditions, :standardise_sql
      end
    end
  end
  
  module ClassMethods    
    def tune_my_query(command_type)
       @command_type = command_type      
    end
    
    def standardise_sql(*conditions)
      conditions = conditions.dup
      @adapter = connection && !connection.class.to_s.include?("PostgreSQLAdapter")
      command = "#{@command_type.to_s.camelize}Command".constantize
      if @adapter      
        conditions.each { |condition| command.execute(condition) }
      end
      super_merge_conditions(*conditions)
    end    
  end
  
end