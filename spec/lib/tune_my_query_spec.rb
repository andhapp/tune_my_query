require 'spec_helper'

describe "TuneMyQuery" do

  shared_examples_for "a class that responds to tune_my_query method" do
    it "should respond to method tune_my_query" do
      Auberdine.should respond_to(:tune_my_query)
    end
  end

  shared_examples_for "" do
  end

  context "When connected to MySql" do
    before do
      connect('mysql')
    end

    it_should_behave_like "a class that responds to tune_my_query method"

    context "for LIKE SQL command" do
      it "should convert from postgresql specific to standard SQL" do
        Auberdine.where("name = 'joe' AND description ilike 'main'").to_sql.should include %{name = 'joe' AND description like 'main'}
      end

      it "should ensure that other model objects work normally" do
        Exodar.where("name = 'joe'").to_sql.should include %{name = 'joe'}
      end

    end

  end

  context "When connected to PostgreSql" do
    before do
      connect('postgres')
    end

    #it_should_behave_like "a class that responds to tune_my_query method"

    context "for LIKE SQL command" do
      it "should not convert from postgresql specific to standard SQL" do
        Auberdine.where("name = 'joe' AND description ilike 'main'").to_sql.should include %{name = 'joe' AND description ilike 'main'}
      end

      it "should ensure that other model objects work normally" do
        Exodar.where("name = 'joe'").to_sql.should include %{name = 'joe'}
      end

    end

  end

end
