class Field < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Resolver

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
    include Model
    model Field, :find

    include Trailblazer::Operation::Representer
    representer ShowRepresenter

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
