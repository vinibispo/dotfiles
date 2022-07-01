(local forem-nvim (require :forem-nvim))
(local api-key (os.getenv :FOREM_API_KEY))

(forem-nvim.setup {:api_key api-key})
