# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "nokogiri"
require "faker"

puts 'Destroy All Users'
User.destroy_all
puts 'Destroy all Assos'
Asso.destroy_all
puts 'Destroy all Events'
Event.destroy_all

puts "Creating Users..."
presidents = []

10.times do
  user = User.create!(
    nickname: Faker::FunnyName.name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456",
    day_birth: Faker::Date.birthday(min_age: 18, max_age: 65)
  )
  puts 'Create 1 user'
  presidents << user
end

puts "Creating Assos..."

def assign_photo(asso, url)
  file = URI.open(url)
  asso.photo.attach(io: file, filename: "logo#{asso}", content_type: 'image/png')
  asso.save!
  puts 'Image asso ajouté'
end

def assign_photo_event(event, url)
  file = URI.open(url)
  event.photos.attach(io: file, filename: "logo#{event}", content_type: 'image/png')
  event.save!
  puts 'Image ajouté'
end

def sum_hours(event)
  event.number_hours = ((event.end_date.to_time - event.start_date.to_time) / 1.hours).round
  event.save!
  puts "Create #{event.name}"
end


puts 'create first user'
user_1 = User.new(first_name:'Mélissa', last_name:'Gateau', email: 'meli@gmail.com', nickname: 'Mel',causes_preferences: 'Environnement', encrypted_password: "1234567")
assign_photo(user_1, "https://avatars.githubusercontent.com/meligateau")





puts 'create fisrt asso'
asso_1 = Asso.new(name: 'Surfrider', description: 'Association devenue une référence dans le combat pour la protection de l océan et de ses usagers.', user: presidents[0])
assign_photo(asso_1, "https://upload.wikimedia.org/wikipedia/fr/f/ff/Logo_surfrider_fondation2020.png")
puts 'create second asso'
asso_2 = Asso.new(name: 'Sea Sheperd', description: 'Association vouée à la protection des écosystèmes marins et de la biodiversité', user: presidents[1])
assign_photo(asso_2, "https://seashepherd.fr/wp-content/uploads/2020/04/logo_sea_shepherd_black.png")
puts 'create third asso'
asso_3 = Asso.new(name: 'Le Petit Biclou', description: 'Association d’auto-réparation de vélo participative, autogérée et solidaire qui a pour but d accompagner les cyclistes dans leur pratique du vélo.', user: presidents[2])
assign_photo(asso_3, "https://www.lepetitbiclou.fr/assets/img/logo/Cosmonaute_glxy.png")
puts 'create fourth asso'
asso_4 = Asso.new(name: 'Atouts Cours', description: 'Association  d’aide, d’accueil et d’accès aux droits en faveur des plus défavorisés', user: presidents[3])
assign_photo(asso_4, "https://www.tousbenevoles.org/images/association/1643293666.png")
puts 'create fifth asso'
asso_5 = Asso.new(name: 'Petits Princes', description: 'Association  qui s est donnée pour but de réaliser les rêves d enfants et adolescents malades.', user: presidents[4])
assign_photo(asso_5, "https://upload.wikimedia.org/wikipedia/fr/thumb/2/24/Association_Petits_Princes_-_Logo.png/600px-Association_Petits_Princes_-_Logo.png")
puts 'create sixth asso'
asso_6 = Asso.new(name: 'Association Sportive et Culturelle de Montsouris', description: 'Association familiale qui apprend à nager et à se perfectionner', user: presidents[5])
assign_photo(asso_6, "https://www.icone-png.com/png/45/44979.png")
puts 'create seventh asso'
asso_7 = Asso.new(name: 'Odysséa', description: 'Association qui finance la recherche contre le cancer du sein en organisant des courses en France', user: presidents[6])
assign_photo(asso_7, "https://images.squarespace-cdn.com/content/v1/5b8c5e20372b96636fb80393/1613480850359-EK0LV8GX4AO3NV2T9JRH/LOGO+ODYSSEA-1.png")
puts 'create eighth asso'
asso_8 = Asso.new(name: 'RSI - Roller Squad Institut', description: 'Association pour juniors, ados, adultes qui propose des cours, stages,randonnées avec pour but d apprendre ou de se perfectionner à la pratique du roller', user: presidents[7])
assign_photo(asso_8, "https://rsi.asso.fr/images/theme/logos/logo_rsi.png")
puts 'create ninth asso'
asso_9 = Asso.new(name: 'Fondation des Femmes', description: 'Association qui agit pour les droits des femmes et la lutte contre les violences dont elles sont victimes.', user: presidents[8])
assign_photo(asso_9, "https://femmesautistesfrancophones.com/wp-content/uploads/2018/10/Logo-Alternatif.png")
puts 'create tenth asso'
asso_10 = Asso.new(name: 'Secours Populaire de Paris', description: 'Association qui organise des maraudes.', user: presidents[9])
assign_photo(asso_10, "https://upload.wikimedia.org/wikipedia/fr/thumb/8/80/Secours_populaire_logo.svg/640px-Secours_populaire_logo.svg.png")

puts "Creating Events..."

event_1 = Event.new(name: 'Collecte de déchets', description: 'Nettoyer nos quais, départ depuis le lieu de rdv. Vous pouvez partir dès que votre sac est plein ;)', address:'Pl. Valhubert, 75000 Paris', cause: Event::EVENT_CAUSES[1], start_date:'Sun, 22 May 2022 14:00:00 +0100', end_date:'Sun, 22 May 2022 18:00:00 +0100', number_volunteers: 50, asso: Asso.find_by(name: 'Surfrider'))
assign_photo_event(event_1, "https://cdn.paris.fr/paris/2020/09/17/huge-41dbf23d558fd523ce69a62c8e3b7cfc.jpg")
sum_hours(event_1)
event_2 = Event.new(name: 'Nettoyage Canal Saint-Martin', description: 'Ramasser avec des émants ou à l épuisette les déchets de nos compatriotes qui ont oublié leur éducation le temps d un instant' , address: '1 Bd Jules Ferry, 75011 Paris', cause:  Event::EVENT_CAUSES[1], start_date:'Sat, 16 Apr 2022 09:00:00 +0100', end_date:'Sat, 16 Apr 2022 13:00:00 +0100', number_volunteers: 30, asso: Asso.find_by(name: 'Sea Sheperd'))
assign_photo_event(event_2, "https://www.parisinsidersguide.com/image-files/canal-saint-martin-bridge-123rf-800-2x1.jpg")
sum_hours(event_2)
event_3 = Event.new(name: 'Atelier restauration vélos', description: 'Venez nous aider à remettre en état des vélo', address: '58 Rue Damesme, 75013 Paris', cause:  Event::EVENT_CAUSES[2], start_date: 'Wed, 18 May 2022 10:00:00 +0100', end_date:'Wed, 18 May 2022 17:00:00 +0100', number_volunteers: 10, asso: Asso.find_by(name: 'Le Petit Biclou'))
assign_photo_event(event_3, "https://www.lenouveleconomiste.fr/wp-content/uploads/2020/12/la-reparation-de-velo-a-paris-en-crise-de-croissance-826x459.jpg")
sum_hours(event_3)
event_4 = Event.new(name: 'Cours de français', description: 'Apprendre à parler français à un groupe de 10 personnes', address: '23 Rue Clovis, 75005 Paris', cause:  Event::EVENT_CAUSES[2], start_date:'Fri, 22 Apr 2022 11:00:00 +0100', end_date: 'Fri, 22 Apr 2022 13:00:00 +0100', number_volunteers: 1, asso: Asso.find_by(name: 'Atouts Cours'))
assign_photo_event(event_4, "https://cdn.paris.fr/paris/2020/03/31/huge-ffafc7d5aa953d87761152c593c462b1.jpg")
sum_hours(event_4)
event_5 = Event.new(name: 'Fete de Noël', description: 'Venez distribuer des cadeaux et animer une journée', address: '149 Rue de Sèvres, 75015 Paris', cause:  Event::EVENT_CAUSES[0], start_date:'Wed, 21 Dec 2022 13:00:00 +0100', end_date: 'Wed, 21 Dec 2022 19:00:00 +0100', number_volunteers: 8, asso: Asso.find_by(name: 'Petits Princes'))
assign_photo_event(event_5, "https://cdn.radiofrance.fr/s3/cruiser-production/2020/12/838e7446-95f9-4e27-aaf4-137287a2cd2b/870x489_maxnewsworldfive333535.jpg")
sum_hours(event_5)
event_6 = Event.new(name: 'Fete de fin d année', description: 'Volontaires pour aider au bar à bonbons/boissons/gâteaux de la fête avant les grandes vacances' , address: '5 Pl. Paul Verlaine, 75013 Paris', cause:  Event::EVENT_CAUSES[0], start_date: 'Sat, 21 Jun 2022 18:30:00 +0100' , end_date: 'Sat, 21 Jun 2022 20:30:00 +0100', number_volunteers: 3, asso: Asso.find_by(name: 'Association Sportive et Culturelle de Montsouris'))
assign_photo_event(event_6, "https://images.lanouvellerepublique.fr/image/upload/t_1020w/f_auto/5a289bf9479a45393f8b45a9.jpg")
sum_hours(event_6)
event_7 = Event.new(name: 'Village Odysséa', description:'Besoin de volontaires pour aider dans la team organisation de la vie de l événement de la course Odysséa Paris', address:'2 Rte de la Ferme, 75012 Paris', cause:  Event::EVENT_CAUSES[4], start_date:'Sat, 01 Oct 2022 08:00:00 +0100', end_date:'Sun, 02 Oct 2022 20:00:00 +0100', number_volunteers: 100, asso: Asso.find_by(name: 'Odysséa'))
assign_photo_event(event_7, "https://www.sortiraparis.com/images/80/1366/62791-odyssea-courses-marches-contre-le-cancer-du-sein-bois-chateau-de-vincennes.jpg")
sum_hours(event_7)
event_8 = Event.new(name: 'Animation atelier roller/skate', description: 'Volontaires pour encadrer une journée autour des roulettes à Paris. Au programme des ateliers d apprentissage et de jeux', address: 'Place de la République, 75011 Paris', cause:  Event::EVENT_CAUSES[0], start_date:'Sun, 01 May 2022 09:00:00 +0100', end_date: 'Sun, 01 May 2022 20:00:00 +0100', number_volunteers: 15, asso: Asso.find_by(name: 'RSI - Roller Squad Institut'))
assign_photo_event(event_8, "https://www.ville-gap.fr/sites/default/files/img_apidae/9619498.jpg")
sum_hours(event_8)
event_9 = Event.new(name: 'Atelier de sensibiliation contre les violences', description: 'Venez échanger sur votre expérience et vos démarches judiciaires', address: '2 Rue Aristide Maillol, 75015 Paris', cause:  Event::EVENT_CAUSES[3], start_date:'Sat, 12 Mar 2022 15:00:00 +0100' , end_date: 'Sat, 12 Mar 2022 19:00:00 +0100', number_volunteers: 20, asso: Asso.find_by(name: 'Fondation des Femmes'))
assign_photo_event(event_9, "https://www.penmarch.fr/wp-content/uploads/2021/03/Espace-jeunes-Atelier-prevention-fevrier-2021.jpg")
sum_hours(event_9)
event_10 = Event.new(name: "Maraude", description: 'distribution de repas', address: '10 bis Av. Trudaine, 75009 Paris', cause:  Event::EVENT_CAUSES[5], start_date:'Fri, 25 Mar 2022 18:00:00 +0100', end_date: 'Fri, 25 Mar 2022 23:00:00 +0100', number_volunteers: 20, asso: Asso.find_by(name: 'Secours Populaire de Paris'))
assign_photo_event(event_10, "https://www.ssvp.fr/wp-content/uploads/2015/05/maraude-1.jpg")
sum_hours(event_10)
puts "Finished!"
