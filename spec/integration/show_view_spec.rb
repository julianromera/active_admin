require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe_with_render "Show View" do
  
  describe "GET #show" do
    before(:each) do
      Admin::PostsController.reset_show_config!
    end
    
    describe "default output" do
      before do
        @post = Post.create(:title => "Hello World", :body => "Woot Woot")
        get :show, :id => @post.id
      end
      
      it "should render default view" do
        response.should have_tag("th", "Title")
        response.should have_tag('td', 'Hello World')
      end
    end
    
    describe "custom output" do
      before(:each) do
        Admin::PostsController.show do
          "Woot Bang"
        end
        @post = Post.create(:title => "Hello World", :body => "Woot Woot")
        get :show, :id => @post.id
      end
      
      it "should render contents" do
        response.body.should include("Woot Bang")
      end
    end
  end
end
