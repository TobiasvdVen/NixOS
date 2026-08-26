pub mod app;
pub mod app_model;
pub mod view;

use std::env;

use nixos_tools_core::flake::Flake;

use crate::app::NixosToolsApp;
use crate::app_model::AppModel;

fn main() -> anyhow::Result<()>
{
    let file_dialog = rfd::FileDialog::new();

    let selected_file = file_dialog
        .add_filter("flake", &["nix"])
        .set_directory("~/")
        .pick_file()
        .ok_or(anyhow::format_err!("flake not found"))?;

    let flake = Flake::load(selected_file)?;

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

    let model = AppModel::from_flake(flake);

    eframe::run_native(
        "NixOS Tools",
        eframe_options,
        Box::new(|_cc| Ok(Box::new(NixosToolsApp::new(model))))
    )?;

    Ok(())
}
