#= require jquery.dataTables.min
#= require dataTables-bootstrap3

$('#study_materials_table').dataTable()

$ ->
	$("#new_study_material").fileupload
		dataType: "script"
		add: (e, data) ->
			unless /^[A-Z]{3}\d{4}\-/.test(data.files[0].name)
				alert "Nome do arquivo precisa começar com o código da disciplina e um traço. Exemplo: \"MAT1200-Lista 1.pdf\""
				return false
			abbreviation = data.files[0].name.split("-")[0]
			if validAbbreviations.indexOf(abbreviation) is -1
				alert "Essa disciplina não existe ou você não está autorizado: " + abbreviation
				return false
			data.context = $(tmpl("template-upload", data.files[0]))
			$(".panel-upload .list-group").append data.context
			data.submit()

		progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10)
				data.context.find(".progress-bar").css "width", progress + "%"

		done: (e, data) ->
			if data.context
				data.context.find(".progress").removeClass "progress-striped active"
				data.context.find(".progress-bar").addClass "progress-bar-success"
