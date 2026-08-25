pub mod app;
pub mod app_model;
pub mod view;

use std::env;

use crate::app::NixosToolsApp;

fn main() -> anyhow::Result<()>
{
    let persistence_path = env::current_dir()?.join(".nixos_tools/default_window_state.json");

    let eframe_options = eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default()
            .with_position([1920.0, 0.0])
            .with_inner_size([1024.0, 512.0])
            .with_min_inner_size([300.0, 220.0]),
        persist_window: true,
        persistence_path: Some(persistence_path),
        ..Default::default()
    };

    eframe::run_native(
        "NixOS Tools",
        eframe_options,
        Box::new(|_cc| Ok(Box::new(NixosToolsApp::default())))
    )?;

    Ok(())
}
