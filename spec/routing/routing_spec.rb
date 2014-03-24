require "spec_helper"

describe 'Routing' do

  # Static
  it { should route(:get, '/').to('static#index') }
  xit { should route(:get, '/index').to('static#index') }
  it { should route(:get, '/ping').to('static#ping') }

  # Courses
  it { should route(:get, '/disciplinas').to('courses#index') }
  it { should route(:get, '/disciplinas/new').to('courses#new') }
  it { should route(:post, '/disciplinas').to('courses#create') }
  it { should route(:get, '/disciplinas/1').to('courses#show', id: '1') }
  it { should route(:get, '/disciplinas/1/edit').to('courses#edit', id: '1') }
  it { should route(:put, '/disciplinas/1').to('courses#update', id: '1') }
  it { should route(:delete, '/disciplinas/1').to('courses#destroy', id: '1') }

  # StudyMaterials
  it { should route(:get, '/disciplinas/INF1005/study_materials').to('study_materials#index', course_id: 'INF1005') }
  it { should route(:post, '/disciplinas/INF1005/study_materials').to('study_materials#create', course_id: 'INF1005') }
  it { should route(:delete, '/disciplinas/INF1005/study_materials/1').to('study_materials#destroy', course_id: 'INF1005', id: '1') }

  # Users
  it { should route(:get, '/users').to('users#index') }
  it { should route(:put, '/users/1/role').to('users#role', id: '1') }

  # Authentication
  it { should route(:get, '/auth/facebook/callback').to('sessions#create', provider: 'facebook') }
  it { should route(:get, '/signout').to('sessions#destroy') }

end