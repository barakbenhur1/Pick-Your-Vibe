//
//  ViewModel.swift
//  Pick Your Vibe
//
//  Created by Barak Ben Hur on 05/07/2025.
//

protocol BaseViewModel {
    var selectedVibe: Vibe? { get set }
    func selectVibe(_ vibe: Vibe?, complition: @escaping (_ value: Vibe?) -> ())
}
