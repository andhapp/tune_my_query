module TuneMyQuery
  def self.included(base)
    base.class_eval do
      extend ClassMethods
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