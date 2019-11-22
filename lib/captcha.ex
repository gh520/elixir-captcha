defmodule Captcha do
  # allow customize receive timeout, default: 10_000
  def get(timeout \\ 1_000) do
    Port.open({:spawn, Path.join(Application.app_dir(:captcha), "/priv/captcha")}, [:binary])

    # Allow set receive timeout
    receive do
      {_, {:data, data}} ->
        <<text::bytes-size(5), img::binary>> = data
        {:ok, text, img }

      other -> other
    after timeout ->
      {:timeout}
    end
  end
end
