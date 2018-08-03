require './lib/driftrock_cli.rb'

describe DriftrockCli do

  # need additional tests
  # - what if there are multiple users that are most loyal. Should all be output?
  # - what should happen if no user are there to be loyal yet? Edge case probably.

  # - what if there are multiple items that are most sold. Should all be output?
  # - what should happen if no products yet? Edge case probably.

  # Need a integration test. Might need to pass in ApiClient to DriftrockCli to make test easier.
  # Not doing cause of time limitation in challenge.


  before do
    @purchases = [{"user_id"=>"FFWN-1CKR-X4WU-Q44M", "item"=>"Awesome Marble Clock", "spend"=>"69.44"},
    {"user_id"=>"HEI7-W5NW-OO9S-Z382", "item"=>"Synergistic Concrete Pants", "spend"=>"9.87"},
    {"user_id"=>"HEI7-W5NW-OO9S-Z382", "item"=>"Synergistic Concrete Pants", "spend"=>"76.06"}
   ]
  
   # simplified by removed keys phone, last name and first name.
   @users = [{"id"=>"HEI7-W5NW-OO9S-Z382", "email"=>"pearlie.yost@greenholt.biz"},
            {"id"=>"FFWN-1CKR-X4WU-Q44M", "email"=>"kelley_paucek@jakubowski.biz"},
            {"id"=>"7IE1-PDJ4-IPH6-8K3L", "email"=>"homenick_lou@kuhntrantow.org"}]
  end

  it '#most_sold' do
    expect(DriftrockCli.most_sold(@purchases)).to eq("Synergistic Concrete Pants")
  end

  describe '#total_spend' do
    context 'email provided' do
      it 'outputs spendings' do
        spending = DriftrockCli.total_spend(@users, @purchases, 'pearlie.yost@greenholt.biz')
        expect(spending).to eq(85.93)
      end
    end

    context 'no email provided' do
      it 'outputs error message' do
        expect { DriftrockCli.execute(['total_spend', '']) }.
          to output("Need a user email.\n").to_stdout
      end
    end

    context 'non-existent email' do
      it 'outputs error message' do
        spending = DriftrockCli.total_spend(@users, @purchases, 'nonexisting@email.com')
        expect(spending).to eq('No user found with that email.')
      end
    end

    context 'user has not spent anything' do
      it 'outputs thta user has 0 spendings' do
        spending = DriftrockCli.total_spend(@users, @purchases, 'homenick_lou@kuhntrantow.org')
        expect(spending).to eq(0)
      end
    end
  end

  it '#most_loyal' do
    most_loyal_user = DriftrockCli.most_loyal(@users, @purchases)
    expect(most_loyal_user).to eq('pearlie.yost@greenholt.biz')
  end

  it '#log' do
    expect { DriftrockCli.log('hello world') }.
    to output("hello world\n").to_stdout
  end
end
