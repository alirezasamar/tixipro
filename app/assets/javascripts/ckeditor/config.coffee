CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = '655'
  config.height = '192'

  config.toolbar_Pure = [
    # { name: 'document',    items: [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
    # { name: 'clipboard',   items: [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
    # { name: 'editing',     items: [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
    # { name: 'tools',       items: [ 'Maximize', 'ShowBlocks','-','About' ] }
    '/',
    # { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline' ] },
    # { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Blockquote' ] },
    # { name: 'links',       items: [ 'Link','Unlink','Anchor' ] },
    #'/',
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    # { name: 'colors',      items: [ 'TextColor','BGColor' ] },
    { name: 'insert',      items: [ 'Image','Flash','Smiley' ] },
    # { name: 'insert',      items: [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
  ]

  config.image_previewText = ' ';

  config.toolbar = 'Pure'
  true

  # Define changes to default configuration here. For example:
  # config.language = 'fr';
  # config.uiColor = '#AADC6E';

  # Filebrowser routes

  # The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files"

  # The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files"

  # The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files"

  # The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures"

  # The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures"

  # The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures"

  # The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files"

  # Rails CSRF token
  config.filebrowserParams = ->
    csrf_token = undefined
    csrf_param = undefined
    meta = undefined
    metas = document.getElementsByTagName("meta")
    params = new Object()
    i = 0

    while i < metas.length
      meta = metas[i]
      switch meta.name
        when "csrf-token"
          csrf_token = meta.content
        when "csrf-param"
          csrf_param = meta.content
        else
          continue
      i++
    params[csrf_param] = csrf_token  if csrf_param isnt `undefined` and csrf_token isnt `undefined`
    params

  config.addQueryString = (url, params) ->
    queryString = []
    unless params
      return url
    else
      for i of params
        queryString.push i + "=" + encodeURIComponent(params[i])
    url + ((if (url.indexOf("?") isnt -1) then "&" else "?")) + queryString.join("&")


  # Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
  CKEDITOR.on "dialogDefinition", (ev) ->

    # Take the dialog name and its definition from the event data.
    dialogName = ev.data.name
    dialogDefinition = ev.data.definition
    content = undefined
    upload = undefined
    if CKEDITOR.tools.indexOf([
      "link"
      "image"
      "attachment"
      "flash"
    ], dialogName) > -1
      content = (dialogDefinition.getContents("Upload") or dialogDefinition.getContents("upload"))
      upload = ((if not content? then null else content.get("upload")))
      if upload and upload.filebrowser and upload.filebrowser["params"] is `undefined`
        upload.filebrowser["params"] = config.filebrowserParams()
        upload.action = config.addQueryString(upload.action, upload.filebrowser["params"])
    return

  return
