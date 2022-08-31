json.task do
  json.extract! @user,
    :id,
    :name,
    :authenitication_token
  end
end
