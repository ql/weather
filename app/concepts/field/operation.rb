class Field < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Field, :create

    contract Contract::Create

    def process(params)
      validate(params[:field]) do |f|
        f.save
      end
    end
  end

  class Show < Trailblazer::Operation
    include Trailblazer::Operation::Representer
    include Resolver
    representer Representer::Show

    def self.model!(params)
      params[:user].fields.find(params[:id])
    end

    def process(*)
    end
  end

  class Update < Create
    include Model
    model Field, :find
    action :update

    contract Contract::Create
  end

  class Delete < Trailblazer::Operation
    include Model
    model Field, :find

    def process(params)
      model.destroy
    end
  end
end
