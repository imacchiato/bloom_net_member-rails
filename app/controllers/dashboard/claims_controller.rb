module Dashboard
  class ClaimsController < BaseController

    def new
      run Claims::Operation::New
    end

    def create
      run Claims::Operation::Create do |result|
        return redirect_to(dashboard_claim_path(result["model"]))
      end

      render :new
    end

    def show
      run Claims::Operation::Show
    end

    def index
      @claims = Claim.order(created_at: :desc).page(params[:page])
    end

  end
end
