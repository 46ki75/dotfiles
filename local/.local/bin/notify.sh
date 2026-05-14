#!/usr/bin/env bash

# Windows Notification

message="${1:-Notification}"
title="${2:-WSL}"

powershell.exe -Command "
  [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType=WindowsRuntime] | Out-Null
  \$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
  \$elements = \$template.GetElementsByTagName('text')
  \$elements.Item(0).InnerText = '$title'
  \$elements.Item(1).InnerText = '$message'
  \$toast = [Windows.UI.Notifications.ToastNotification]::new(\$template)
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('WSL').Show(\$toast)
"
