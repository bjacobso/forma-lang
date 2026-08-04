; content-protocol.lisp
; -----------------------------------------------------------------------------
; Hosted ContentProtocol protocol descriptors.
; -----------------------------------------------------------------------------

(define-protocol ContentProtocol
  (record ContentText
    (:schema-name ContentText)
    (:fields
      (:kind (:kind literal) (:values [text]) (:required true))
      (:value (:type string) (:required true))))

  (record ContentMarkdown
    (:schema-name ContentMarkdown)
    (:fields
      (:kind (:kind literal) (:values [md]) (:required true))
      (:content (:type string) (:required true))))

  (record ContentCode
    (:schema-name ContentCode)
    (:fields
      (:kind (:kind literal) (:values [code]) (:required true))
      (:content (:type string) (:required true))))

  (record ContentH1
    (:schema-name ContentH1)
    (:fields
      (:kind (:kind literal) (:values [h1]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentH2
    (:schema-name ContentH2)
    (:fields
      (:kind (:kind literal) (:values [h2]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentH3
    (:schema-name ContentH3)
    (:fields
      (:kind (:kind literal) (:values [h3]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentParagraph
    (:schema-name ContentParagraph)
    (:fields
      (:kind (:kind literal) (:values [p]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentUnorderedList
    (:schema-name ContentUnorderedList)
    (:fields
      (:kind (:kind literal) (:values [ul]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentOrderedList
    (:schema-name ContentOrderedList)
    (:fields
      (:kind (:kind literal) (:values [ol]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentListItem
    (:schema-name ContentListItem)
    (:fields
      (:kind (:kind literal) (:values [li]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentBold
    (:schema-name ContentBold)
    (:fields
      (:kind (:kind literal) (:values [bold]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentItalic
    (:schema-name ContentItalic)
    (:fields
      (:kind (:kind literal) (:values [italic]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentLink
    (:schema-name ContentLink)
    (:fields
      (:kind (:kind literal) (:values [link]) (:required true))
      (:href (:type string) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (record ContentDoc
    (:schema-name ContentDoc)
    (:fields
      (:kind (:kind literal) (:values [doc]) (:required true))
      (:children (:kind array) (:item ContentNode) (:required true))))

  (sum ContentNode
    (:schema-name ContentNodeSchema)
    (:members
      (:text (:ref ContentText))
      (:md (:ref ContentMarkdown))
      (:code (:ref ContentCode))
      (:h1 (:ref ContentH1))
      (:h2 (:ref ContentH2))
      (:h3 (:ref ContentH3))
      (:p (:ref ContentParagraph))
      (:ul (:ref ContentUnorderedList))
      (:ol (:ref ContentOrderedList))
      (:li (:ref ContentListItem))
      (:bold (:ref ContentBold))
      (:italic (:ref ContentItalic))
      (:link (:ref ContentLink))
      (:doc (:ref ContentDoc)))))
