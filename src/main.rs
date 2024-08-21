// SPDX-FileCopyrightText: 2024 The Input Leap Team
//
// SPDX-License-Identifier: GPL-3.0-or-later

use wayland_client::{Connection, Dispatch, QueueFreezeGuard, protocol::{wl_registry}};

struct AppData;

impl Dispatch<wl_registry::WlRegistry, ()> for AppData {
    fn event(
            _state: &mut Self,
            _proxy: &wl_registry::WlRegistry,
            event: <wl_registry::WlRegistry as wayland_client::Proxy>::Event,
            _data: &(),
            _conn: &Connection,
            _qhandle: &wayland_client::QueueHandle<Self>,
        ) {

            if let wl_registry::Event::Global { name, interface, version } = event {
                println!("[{}] {} (v{})", name, interface, version);
            }
    }
}

fn main() {
    let conn = Connection::connect_to_env().unwrap();
    let display = conn.display();

    let mut event_queue = conn.new_event_queue();
    let queue_handle = event_queue.handle();

    _ = display.get_registry(&queue_handle, ());

    event_queue.roundtrip(&mut AppData).unwrap();
}
