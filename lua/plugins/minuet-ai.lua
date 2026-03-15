return {
    'milanglacier/minuet-ai.nvim',
    config = function()
        require('minuet').setup {
            virtualtext = {
                auto_trigger_ft = {},
                keymap = {
                    accept = '<A-A>',
                    accept_line = '<A-a>',
                    accept_n_lines = '<A-z>',
                    prev = '<A-[>',
                    next = '<A-]>',
                    dismiss = '<A-e>',
                },
            },
            provider = 'openai_compatible',
            request_timeout = 2.5,
            throttle = 1500,
            debounce = 600,
            provider_options = {
                openai_compatible = {
                    api_key = 'NVIDIA_INFERENCE_API_KEY',
                    end_point = 'https://inference-api.nvidia.com/v1/chat/completions',
                    model = 'aws/anthropic/claude-haiku-4-5-v1',
                    name = 'claude-haiku-4.5',
                },
            },
        }
    end,
}
