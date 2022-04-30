(local notify (require :notify))
(set vim.notify notify)

(local dap (require :dap))
(fn notify-output [command opts]
  (var output "")
  (var notification nil)
  (local notify
         (fn [msg level]
           (local notify-opts
                  (vim.tbl_extend :keep (or opts {})
                                  {:title (table.concat command " ")
                                   :replace notification}))
           (set notification (vim.notify msg level notify-opts))))
  (local on-data (fn [_ data]
                   (set output (.. output (table.concat data "\n")))
                   (notify output :info)))
  (vim.fn.jobstart command
                   {:on_stdout on-data
                    :on_stderr on-data
                    :on_exit (fn [_ code]
                               (when (= (length output) 0)
                                 (notify (.. "No output of command, exit code: "
                                             code)
                                         :warn)))}))

(local client-notifs {})

(fn get-notif-data [client-id token]
  (when (not (. client-notifs client-id))
    (tset client-notifs client-id {}))
  (when (not (. (. client-notifs client-id) token))
    (tset (. client-notifs client-id) token {}))
  (. (. client-notifs client-id) token))

(local spinner-frames ["⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷"])

(fn update-spinner [client-id token]
  (local notif-data (get-notif-data client-id token))
  (when notif-data.spinner
    (local new-spinner (% (+ notif-data.spinner 1) (length spinner-frames)))
    (set notif-data.spinner new-spinner)
    (set notif-data.notification
         (vim.notify nil nil
                     {:hide_from_history true
                      :icon (. spinner-frames new-spinner)
                      :replace notif-data.notification}))
    (vim.defer_fn #(update-spinner client-id token) 100)))

(fn format-title [title client-name]
  (.. client-name (if (> (length title) 0) (.. ":" title) "")))

(fn format-message [message percentage]
  (.. (if percentage
          (.. percentage "%\t")
          "") (or message "")))

(tset (. dap.listeners.before :event_progressStart) :progress-notifications
      (fn [session body]
        (local notif-data (get-notif-data :dap body.progressId))
        (local message (format-message body.message body.percentage))
        (set notif-data.notification
             (vim.notify message :info
                         {:title (format-title body.title session.config.type)
                          :icon (. spinner-frames 1)
                          :timeout false
                          :hide_from_history false}))
        (set notif-data.notification.spinner 1)
        (update-spinner :dap body.progressId)))

(tset (. dap.listeners.before :event_progressUpdate) :progress-notifications
      (fn [session body]
        (local notif-data (get-notif-data :dap body.progressId))
        (set notif-data.notification
             (vim.notify (format-message body.message body.percentage) :info
                         {:replace notif-data.notification
                          :hide_from_history false}))))

(tset (. dap.listeners.before :event_progressEnd) :progress-notifications
      (fn [session body]
        (local notif-data (. (. client-notifs :dap) body.progressId))
        (set notif-data.notification
             (vim.notify (if body.message
                             (format-message body.message)
                             :Complete) :info
                         {:icon ""
                          :replace notif-data.notification
                          :timeout 3000}))
        (set notif-data.spinner nil)))
