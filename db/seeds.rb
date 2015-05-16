# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p0= Pessoa.create(nome:'Ruan Pablo',cpf:'71225285291',rg:'283845',nascimento:'08/01/1982',email:'71225285291')
puts 'pessoa criada'
a0 = Aluno.create(matricula:'0000000000002',:curso=>Curso.find_by_nome('Licenciatura em Informática'),semestre_atual:'2',ano_ingresso:'2011',pessoa_id:p0.id)
puts 'aluno criado'
