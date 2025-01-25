local setup = require("setup")
return {
	"robitx/gp.nvim",
	config = function()
		local config = {
			chat_dir = vim.fn.expand(setup.chat_dir),
			chat_user_prefix = "## nxtkofi ☕:",
			chat_assistant_prefix = { "## 📖", "{{agent}}:" },
			providers = {
				openai = {
					disable = true,
					endpoint = "https://api.openai.com/v1/chat/completions",
				},
				--[[ ollama = { ]]
				--[[ 	endpoint = "http://localhost:11434/v1/chat/completions", ]]
				--[[ }, ]]
				ollama = {
					endpoint = "http://localhost:11435/query",
				},
				googleai = {
					disable = false,
					endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key={{secret}}",
					secret = os.getenv("GOOGLEAI_API_KEY"),
				},
			},
			agents = {
				{
					disable = false,
					provider = "ollama",
					name = "Llama 🦙",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = {
						model = "llama3.2:3b",
						temperature = 0.8,
						top_p = 1,
						min_p = 0.05,
					},
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI assistant trained on my Zettelkasten main-notes. Your purpose is to provide me helpful insights and reviews. You opt to help me with my day-to-day note taking, template filling and new note's writing.",
				},
				{
					provider = "googleai",
					name = "ChatGemini",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = { model = "gemini", temperature = 0.3, top_p = 1, top_k = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are a general AI assistant.",
				},
				{
					provider = "googleai",
					name = "GeminiHelper",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = { model = "gemini", temperature = 0.8, top_p = 1, top_k = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "Wcielisz się w terapeutę AI. Będziemy omawiać moje codzienne myśli i problemy. Będziesz tłumaczył i podpowiadał co powinienem zrobić w trapiących mnie konfliktach i sytuacjach. Twoje odpowiedzi powinny być rzeczowe i na temat. Skup się na mnie i na tym, co czuję.",
				},
				{
					disable = false,
					provider = "ollama",
					name = "Qwen 🐉",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = {
						model = "qwen2.5:3b",
						temperature = 0.7,
						top_p = 1,
						min_p = 0.05,
					},
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI assistant trained on my Zettelkasten main-notes. Your purpose is to provide me helpful insights and reviews. You opt to help me with my day-to-day note taking, template filling and new note's writing.",
				},
				{
					disable = false,
					provider = "ollama",
					name = "DeepSeek 🌊",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = {
						temperature = 0.7,
						temperature = 0.8,
						top_p = 1,
						min_p = 0.05,
					},
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI assistant trained on my Zettelkasten main-notes. Your purpose is to provide me helpful insights and reviews. You opt to help me with my day-to-day note taking, creating insightful connections between my notes and asking creative questions. All your answers should be supported by Markdown.",
				},
			},
		}
		require("gp").setup(config)
	end,
}
